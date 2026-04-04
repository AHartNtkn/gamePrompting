#!/usr/bin/env bash
set -euo pipefail

# Game Generator
# Creates a game from a concept. The generator has full tool access —
# it writes files, installs dependencies, runs the game, and iterates.
# Usage: ./generate.sh <concept> [--model MODEL] [--output-dir DIR]
#
# <concept> can be:
#   - A number (1-5) referencing a test prompt from test-prompts.md
#   - A string with a game concept
#   - A file path to a file containing the concept

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_TEMPLATE="$SCRIPT_DIR/generator/game-creation-prompt.md"
TEST_PROMPTS="$SCRIPT_DIR/test-prompts.md"

# Defaults
MODEL="sonnet"
OUTPUT_DIR=""
CONCEPT=""
CONTINUE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --model)
            MODEL="$2"
            shift 2
            ;;
        --output-dir|-o)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --continue)
            CONTINUE=true
            shift
            ;;
        *)
            if [[ -z "$CONCEPT" ]]; then
                CONCEPT="$1"
            else
                echo "Unknown argument: $1" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$CONCEPT" ]]; then
    echo "Usage: ./generate.sh <concept> [--model MODEL] [--output-dir DIR] [--continue]"
    echo ""
    echo "  concept      A test prompt number, a concept string, or a file path"
    echo "  --model      Claude model to use (default: sonnet)"
    echo "  --output-dir Output directory for game files (default: games/<name>/)"
    echo "  --continue   Resume development on existing game (skip archive/clean)"
    echo ""
    echo "Test prompts (from test-prompts.md):"
    grep '^## Prompt [0-9]*:' "$TEST_PROMPTS" | sed 's/^## Prompt \([0-9]*\): \(.*\)/  \1  \2/'
    exit 1
fi

if [[ ! -f "$PROMPT_TEMPLATE" ]]; then
    echo "Missing prompt template: $PROMPT_TEMPLATE" >&2
    exit 1
fi

# Resolve concept
CONCEPT_TEXT=""
CONCEPT_NAME=""

if [[ "$CONCEPT" =~ ^[0-9]+$ ]]; then
    PROMPT_NUM="$CONCEPT"
    CONCEPT_TEXT="$(awk -v n="$PROMPT_NUM" '
        /^## Prompt '"$PROMPT_NUM"':/ { found=1; next }
        found && /^(## |---)/ { exit }
        found && NF { print }
    ' "$TEST_PROMPTS")"

    if [[ -z "$CONCEPT_TEXT" ]]; then
        echo "Could not extract test prompt $PROMPT_NUM from $TEST_PROMPTS" >&2
        exit 1
    fi

    CONCEPT_NAME="$(awk -v n="$PROMPT_NUM" '
        /^## Prompt '"$PROMPT_NUM"':/ { sub(/^## Prompt [0-9]+: */, ""); gsub(/ /, "-"); print tolower($0); exit }
    ' "$TEST_PROMPTS")"
elif [[ -f "$CONCEPT" ]]; then
    CONCEPT_TEXT="$(cat "$CONCEPT")"
    CONCEPT_NAME="$(basename "$CONCEPT" | sed 's/\.[^.]*$//')"
else
    CONCEPT_TEXT="$CONCEPT"
    CONCEPT_NAME="$(echo "$CONCEPT" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]' '-' | head -c 30 | sed 's/-$//')"
fi

ARCHIVE_DIR="$HOME/Documents/gameArchive"
GAMES_DIR="$SCRIPT_DIR/games"

# Set default output directory
if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="$GAMES_DIR/${CONCEPT_NAME}"
fi

OUTPUT_DIR="$(realpath -m "$OUTPUT_DIR")"

if [[ "$CONTINUE" == true ]]; then
    if [[ ! -d "$OUTPUT_DIR" ]]; then
        echo "--continue specified but output directory does not exist: $OUTPUT_DIR" >&2
        exit 1
    fi
    echo "Continuing existing game at: $OUTPUT_DIR"
else
    # Archive existing game contents before generating
    if [[ -d "$GAMES_DIR" ]] && ls -A "$GAMES_DIR" | grep -qv '^\.git' 2>/dev/null; then
        TIMESTAMP="$(date -u +%Y%m%d-%H%M%S)"
        ARCHIVE_DEST="$ARCHIVE_DIR/$TIMESTAMP"
        mkdir -p "$ARCHIVE_DEST"
        # Move everything except .git files
        find "$GAMES_DIR" -mindepth 1 -maxdepth 1 ! -name '.git*' -exec mv {} "$ARCHIVE_DEST/" \;
        echo "Archived previous game(s) to: $ARCHIVE_DEST"
    fi

    # Clean output directory so the generator starts fresh
    rm -rf "$OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

# Assemble the full prompt
TEMPLATE_TEXT="$(cat "$PROMPT_TEMPLATE")"
FULL_PROMPT="${TEMPLATE_TEXT//GAME_CONCEPT_HERE/$CONCEPT_TEXT}"
FULL_PROMPT="${FULL_PROMPT//GAME_OUTPUT_DIR/$OUTPUT_DIR}"

CONTINUATION_TEXT="## CONTINUATION

The previous generation session ended before the development loop completed. There is an incomplete implementation in the output directory. Read dev-status.md and dev-log.md to understand what was completed and what remains. Continue from where the previous session left off. Do not start over — build on what exists. Complete any unfinished verification waves, run the pre-delivery checklist, and ensure all 7 agents reach VERIFIED status."

if [[ "$CONTINUE" == true ]]; then
    FULL_PROMPT="${FULL_PROMPT}

${CONTINUATION_TEXT}"
fi

echo "Game Generator"
echo "  Concept: ${CONCEPT_NAME}"
echo "  Model: $MODEL"
echo "  Output: $OUTPUT_DIR"
echo "  Continue: $CONTINUE"
echo ""
echo "Generating..."
echo ""

# Load custom agents from .claude/agents/ for --agents flag.
# claude -p does not auto-discover agents; they must be passed as JSON.
AGENTS_DIR="$SCRIPT_DIR/.claude/agents"
AGENTS_JSON="{}"
if [[ -d "$AGENTS_DIR" ]]; then
    for agent_file in "$AGENTS_DIR"/*.md; do
        [[ -f "$agent_file" ]] || continue
        agent_name=$(basename "$agent_file" .md)

        # Extract frontmatter fields
        description=$(awk '/^---$/{n++; next} n==1 && /^description:/{sub(/^description: */, ""); print; exit}' "$agent_file")
        tools=$(awk '/^---$/{n++; next} n==1 && /^tools:/{sub(/^tools: */, ""); print; exit}' "$agent_file")

        # Extract body (everything after second ---)
        prompt=$(awk '/^---$/{n++; next} n>=2{print}' "$agent_file")

        # Build JSON entry
        agent_json=$(jq -n \
            --arg desc "$description" \
            --arg prompt "$prompt" \
            --arg tools "$tools" \
            '{description: $desc, prompt: $prompt, tools: ($tools | gsub("[\\[\\] ]"; "") | split(","))}')

        AGENTS_JSON=$(echo "$AGENTS_JSON" | jq --arg name "$agent_name" --argjson agentdef "$agent_json" '. + {($name): $agentdef}')
    done
fi

# Write agents JSON to temp file (can be large)
AGENTS_TMP=$(mktemp)
echo "$AGENTS_JSON" > "$AGENTS_TMP"

# Two output paths from the stream:
# 1. generation.log — compact valid JSON with large content truncated (for the summarizer)
# 2. terminal — heavily truncated one-liners (for human readability)
GEN_LOG="$SCRIPT_DIR/generation.log"

# Fresh runs start a new log; --continue appends to the existing one.
if [[ "$CONTINUE" != true ]]; then
    : > "$GEN_LOG"
fi

JQ_COMPACT='del(.session_id, .uuid, .timestamp, .parent_tool_use_id, .rate_limit_info, .mcp_servers, .slash_commands, .apiKeySource, .claude_code_version, .output_style, .agents, .skills, .plugins, .fast_mode_state, .permissionMode, .modelUsage, .permission_denials, .message.model, .message.id, .message.usage, .message.stop_reason, .message.stop_sequence, .message.context_management, .tool_use_result, .total_cost_usd, .usage, .duration_ms, .duration_api_ms)
| if .type == "assistant" then
    .message.content = [.message.content[]? |
      if .type == "tool_use" then
        .input = (
          if .name == "Write" or .name == "Edit" then {file_path: .input.file_path}
          elif .name == "Read" then {file_path: .input.file_path}
          elif .name == "Bash" then {command: (.input.command | .[0:300])}
          elif .name == "Agent" then {description: .input.description, prompt: (.input.prompt | tostring | .[0:500])}
          else .input | to_entries | map(select(.value | tostring | length < 300)) | from_entries
          end)
      elif .type == "thinking" then .thinking = (.thinking | .[0:500])
      elif .type == "text" then .text = (.text | .[0:500])
      else . end]
  elif .type == "user" then
    .message.content = [.message.content[]? |
      if .type == "tool_result" then .content = (.content | tostring | .[0:300])
      else . end]
  else . end'

# --- Verification ---

# The 7 verification agents that must all reach VERIFIED status.
REQUIRED_AGENTS=(
    dispatch-verifier
    simulation-verifier
    code-architecture-reviewer
    design-reviewer
    ui-reviewer
    balance-checker
    experience-reviewer
)

# Check whether the game directory has all verification certificates.
# Returns 0 if fully verified, 1 if not. Prints what's missing to stdout.
check_verification() {
    local game_dir="$1"
    local status_file="$game_dir/dev-status.md"
    local missing=()

    if [[ ! -f "$game_dir/run.sh" ]]; then
        echo "MISSING: run.sh"
        return 1
    fi

    if [[ ! -f "$game_dir/game-model.md" ]]; then
        echo "MISSING: game-model.md"
        return 1
    fi

    if [[ ! -f "$status_file" ]]; then
        echo "MISSING: dev-status.md"
        return 1
    fi

    for agent in "${REQUIRED_AGENTS[@]}"; do
        local line
        line=$(grep -i "^- *${agent}:" "$status_file" 2>/dev/null)
        if [[ -z "$line" ]]; then
            missing+=("$agent (not listed)")
            continue
        fi
        local final_status
        final_status=$(echo "$line" | grep -oE '[A-Z]+$')
        if [[ "$final_status" != "VERIFIED" ]]; then
            missing+=("$agent ($final_status)")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "NOT VERIFIED: ${missing[*]}"
        return 1
    fi

    return 0
}

# --- Generation loop ---

CURRENT_PROMPT="$FULL_PROMPT"

while true; do
    PROMPT_TMP=$(mktemp)
    echo "$CURRENT_PROMPT" > "$PROMPT_TMP"

    # Pipe through compact jq filter. Save to log file AND display truncated on terminal.
    claude -p - \
        --model "$MODEL" \
        --output-format stream-json --verbose \
        --tools "Bash,Read,Write,Edit,Glob,Grep,Agent" \
        --permission-mode bypassPermissions \
        --add-dir "$OUTPUT_DIR" \
        --agents "$(cat "$AGENTS_TMP")" \
        < "$PROMPT_TMP" \
        2>&1 | jq -c --unbuffered "$JQ_COMPACT" 2>/dev/null | tee -a "$GEN_LOG" | cut -c1-200 || true

    rm -f "$PROMPT_TMP"

    # Check for API-level failure (rate limit, connection refused, etc.)
    if grep -q '"type":"result".*"is_error":true' "$GEN_LOG" 2>/dev/null; then
        file_count=$(find "$OUTPUT_DIR" -type f -not -path '*/__pycache__/*' 2>/dev/null | wc -l)
        if [[ "$file_count" -eq 0 ]]; then
            echo "API error with no partial work to continue from."
            break
        fi

        echo ""
        echo "API error after partial generation ($file_count files created)."
        echo "Polling every 5 minutes until API recovers..."

        while true; do
            sleep 300
            test_output=$(claude --model "$MODEL" -p "Say OK" 2>&1) || true
            if echo "$test_output" | grep -qiE "hit your limit|API Error|ConnectionRefused|unable to connect"; then
                echo "API still unavailable. Waiting another 5 minutes..."
            else
                echo "API recovered. Resuming generation..."
                break
            fi
        done

        CURRENT_PROMPT="${FULL_PROMPT}

${CONTINUATION_TEXT}"
        continue
    fi

    # No API error — session completed. Check if the game is actually done.
    verify_result=$(check_verification "$OUTPUT_DIR")
    if [[ $? -eq 0 ]]; then
        echo "Verification complete: all agents VERIFIED."
        break
    fi

    echo "Verification incomplete ($verify_result). Restarting generation..."
    CURRENT_PROMPT="${FULL_PROMPT}

${CONTINUATION_TEXT}"
done

rm -f "$AGENTS_TMP"

echo ""

if [[ -f "$OUTPUT_DIR/run.sh" ]]; then
    chmod +x "$OUTPUT_DIR/run.sh"
    echo "Game created at: $OUTPUT_DIR"
    echo "Run with: $OUTPUT_DIR/run.sh"
else
    echo "WARNING: No run.sh found in $OUTPUT_DIR"
    echo "Game files are in $OUTPUT_DIR but no launch script was created."
    ls -la "$OUTPUT_DIR"
fi
