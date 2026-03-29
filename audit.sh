#!/usr/bin/env bash
set -euo pipefail

# Game Design Auditor
# Runs all category audits + sentinel checks against a game.
# The auditor actually plays the game via tmux before scoring.
# Usage: ./audit.sh <game_path> [--model MODEL] [--output-dir DIR] [--parallel N]
#
# game_path can be a single file or a directory containing run.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUDITOR_DIR="$SCRIPT_DIR/auditor"
PREAMBLE="$AUDITOR_DIR/shared-preamble.md"
PROMPTS_DIR="$AUDITOR_DIR/prompts"

# Defaults
MODEL="sonnet"
OUTPUT_DIR=""
GAME_PATH=""
MAX_PARALLEL=6

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --model)
            MODEL="$2"
            shift 2
            ;;
        --output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --parallel|-j)
            MAX_PARALLEL="$2"
            shift 2
            ;;
        *)
            if [[ -z "$GAME_PATH" ]]; then
                GAME_PATH="$1"
            else
                echo "Unknown argument: $1" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$GAME_PATH" ]]; then
    echo "Usage: ./audit.sh <game_path> [--model MODEL] [--output-dir DIR] [--parallel N]"
    echo ""
    echo "  game_path    Path to game file or game directory (containing run.sh)"
    echo "  --model      Claude model to use (default: sonnet)"
    echo "  --output-dir Directory for raw audit outputs (default: auto-generated)"
    echo "  --parallel   Max concurrent auditors (default: 6)"
    exit 1
fi

GAME_PATH="$(realpath "$GAME_PATH")"

if [[ ! -e "$GAME_PATH" ]]; then
    echo "Not found: $GAME_PATH" >&2
    exit 1
fi

if [[ ! -f "$PREAMBLE" ]]; then
    echo "Missing preamble: $PREAMBLE" >&2
    exit 1
fi

# Determine game directory and how to collect source
if [[ -d "$GAME_PATH" ]]; then
    GAME_DIR="$GAME_PATH"
    GAME_NAME="$(basename "$GAME_PATH")"
    if [[ -f "$GAME_DIR/run.sh" ]]; then
        RUN_CMD="$GAME_DIR/run.sh"
    else
        echo "WARNING: No run.sh found in $GAME_DIR. The auditor will need to figure out how to run the game."
        RUN_CMD=""
    fi
    # Collect all source files
    GAME_SOURCE="$(find "$GAME_DIR" -type f \( -name '*.py' -o -name '*.js' -o -name '*.ts' -o -name '*.rb' -o -name '*.rs' -o -name '*.go' -o -name '*.java' -o -name '*.c' -o -name '*.cpp' -o -name '*.lua' -o -name '*.sh' -o -name '*.md' -o -name '*.txt' -o -name '*.json' -o -name '*.yaml' -o -name '*.yml' -o -name '*.toml' -o -name '*.cfg' -o -name '*.ini' \) ! -path '*/__pycache__/*' ! -path '*/node_modules/*' ! -path '*/.git/*' -print0 | sort -z | while IFS= read -r -d '' f; do
        echo "=== $(realpath --relative-to="$GAME_DIR" "$f") ==="
        cat "$f"
        echo ""
    done)"
else
    GAME_DIR="$(dirname "$GAME_PATH")"
    GAME_NAME="$(basename "$GAME_PATH" | sed 's/\.[^.]*$//')"
    RUN_CMD="$GAME_PATH"
    GAME_SOURCE="=== $(basename "$GAME_PATH") ===
$(cat "$GAME_PATH")"
fi

# Archive existing audits
ARCHIVE_DIR="$HOME/Documents/auditArchive"
AUDITS_DIR="$SCRIPT_DIR/audits"

if [[ -d "$AUDITS_DIR" ]] && ls -A "$AUDITS_DIR" | grep -qv '^\.git' 2>/dev/null; then
    TIMESTAMP="$(date -u +%Y%m%d-%H%M%S)"
    ARCHIVE_DEST="$ARCHIVE_DIR/$TIMESTAMP"
    mkdir -p "$ARCHIVE_DEST"
    find "$AUDITS_DIR" -mindepth 1 -maxdepth 1 ! -name '.git*' -exec mv {} "$ARCHIVE_DEST/" \;
    echo "Archived previous audit(s) to: $ARCHIVE_DEST"
fi

# Set up output directory
if [[ -z "$OUTPUT_DIR" ]]; then
    TIMESTAMP="$(date -u +%Y%m%d-%H%M%S)"
    OUTPUT_DIR="$AUDITS_DIR/${GAME_NAME}_${TIMESTAMP}"
fi
mkdir -p "$OUTPUT_DIR"

echo "Game Design Audit"
echo "  Game: $GAME_PATH"
echo "  Model: $MODEL"
echo "  Output: $OUTPUT_DIR"
echo "  Parallel: $MAX_PARALLEL"
echo ""

PREAMBLE_TEXT="$(cat "$PREAMBLE")"

# Game info block shared across all prompts
GAME_INFO="## Game Information

The game directory is: ${GAME_DIR}"

if [[ -n "$RUN_CMD" ]]; then
    GAME_INFO="${GAME_INFO}
Launch script: ${RUN_CMD}"
fi

GAME_INFO="${GAME_INFO}

### Source Code

\`\`\`
${GAME_SOURCE}
\`\`\`

Read the source code above to understand the game's structure, then use Bash to run and play the game. You must actually play it before scoring. Follow the Play Protocol in the preamble."

# --- Parallel execution ---

# Each auditor gets a unique tmux session name to avoid collisions.
# The preamble uses TMUX_SESSION as a placeholder; we substitute it per-auditor.

run_auditor() {
    local id="$1"        # e.g. "A" or "sentinels"
    local prompt_file="$2"
    local output_file="$3"
    local session_name="audit-${id}"

    local category_text
    category_text="$(cat "$prompt_file")"

    # Substitute TMUX_SESSION placeholder with this auditor's unique session name
    local preamble_instance="${PREAMBLE_TEXT//TMUX_SESSION/$session_name}"

    local full_prompt="${preamble_instance}

---

${category_text}

---

${GAME_INFO}"

    # Write prompt to temp file to avoid "Argument list too long" for large games
    local prompt_file_tmp
    prompt_file_tmp=$(mktemp)
    echo "$full_prompt" > "$prompt_file_tmp"

    # Auditor writes its output file directly via the Write tool.
    # This avoids stdout capture failures (empty output, appended commentary).
    local full_prompt_with_output="${full_prompt}

Write your final scored output to: ${output_file}
Use the Write tool to create this file. Do not rely on stdout."

    echo "$full_prompt_with_output" > "$prompt_file_tmp"

    claude -p - \
        --model "$MODEL" \
        --output-format text \
        --tools "Bash,Read,Write" \
        --permission-mode bypassPermissions \
        --add-dir "$GAME_DIR" \
        < "$prompt_file_tmp" \
        > /dev/null 2>/dev/null || true

    if [[ ! -s "$output_file" ]]; then
        mv "$output_file" "${output_file%.txt}_error.txt" 2>/dev/null
    fi

    rm -f "$prompt_file_tmp"
}

# Collect all jobs: categories A-U + sentinels
declare -a JOB_IDS=()
declare -a JOB_PROMPTS=()
declare -a JOB_OUTPUTS=()

for letter in A B C D E F G H I J K L M N O P Q R S T U V W; do
    prompt_file="$PROMPTS_DIR/${letter}.md"
    if [[ -f "$prompt_file" ]]; then
        JOB_IDS+=("$letter")
        JOB_PROMPTS+=("$prompt_file")
        JOB_OUTPUTS+=("$OUTPUT_DIR/${letter}.txt")
    else
        echo "  [${letter}] SKIP — prompt file not found"
    fi
done

# Sentinels run as part of the same parallel pool
sentinel_file="$PROMPTS_DIR/sentinels.md"
if [[ -f "$sentinel_file" ]]; then
    JOB_IDS+=("sentinels")
    JOB_PROMPTS+=("$sentinel_file")
    JOB_OUTPUTS+=("$OUTPUT_DIR/sentinels.txt")
else
    echo "  [SENTINELS] SKIP — prompt file not found"
fi

TOTAL_JOBS=${#JOB_IDS[@]}
echo "Running $TOTAL_JOBS auditors (max $MAX_PARALLEL concurrent)..."
echo ""

# Launch jobs with concurrency limit
declare -A RUNNING_PIDS=()  # pid -> job_id
NEXT_JOB=0

launch_next() {
    if [[ $NEXT_JOB -ge $TOTAL_JOBS ]]; then
        return 1
    fi
    local id="${JOB_IDS[$NEXT_JOB]}"
    local prompt="${JOB_PROMPTS[$NEXT_JOB]}"
    local output="${JOB_OUTPUTS[$NEXT_JOB]}"
    NEXT_JOB=$((NEXT_JOB + 1))

    run_auditor "$id" "$prompt" "$output" &
    local pid=$!
    RUNNING_PIDS[$pid]="$id"
    echo "  [${id}] Started (pid $pid)"
    return 0
}

# Fill initial pool
for ((i = 0; i < MAX_PARALLEL && i < TOTAL_JOBS; i++)); do
    launch_next
done

# Wait for completions, launch replacements
while [[ ${#RUNNING_PIDS[@]} -gt 0 ]]; do
    # Wait for any child to finish
    wait -n -p FINISHED_PID 2>/dev/null || true

    # Find which job finished (check all pids, some may have exited)
    for pid in "${!RUNNING_PIDS[@]}"; do
        if ! kill -0 "$pid" 2>/dev/null; then
            id="${RUNNING_PIDS[$pid]}"
            unset "RUNNING_PIDS[$pid]"

            # Check output
            output_file="$OUTPUT_DIR/${id}.txt"
            if [[ -f "$output_file" ]] && [[ -s "$output_file" ]]; then
                echo "  [${id}] Done"
            else
                echo "  [${id}] ERROR (empty or missing output)"
            fi

            # Launch replacement if jobs remain
            launch_next || true
        fi
    done

    # Brief pause to avoid busy-waiting
    sleep 2
done

echo ""
echo "All auditors complete."

# --- Retry failed auditors ---

while true; do
    # Collect failed auditors
    declare -a FAILED_RETRY_IDS=()
    declare -a FAILED_RETRY_PROMPTS=()
    declare -a FAILED_RETRY_OUTPUTS=()

    for i in "${!JOB_IDS[@]}"; do
        id="${JOB_IDS[$i]}"
        output_file="$OUTPUT_DIR/${id}.txt"
        if [[ ! -f "$output_file" ]] || [[ ! -s "$output_file" ]]; then
            FAILED_RETRY_IDS+=("$id")
            FAILED_RETRY_PROMPTS+=("${JOB_PROMPTS[$i]}")
            FAILED_RETRY_OUTPUTS+=("${JOB_OUTPUTS[$i]}")
        fi
    done

    [[ ${#FAILED_RETRY_IDS[@]} -eq 0 ]] && break

    echo ""
    echo "  ${#FAILED_RETRY_IDS[@]} auditors produced no output: ${FAILED_RETRY_IDS[*]}"
    echo "  Polling every 5 minutes until API recovers..."

    while true; do
        sleep 300
        test_output=$(claude --model "$MODEL" -p "Say OK" 2>&1) || true
        if echo "$test_output" | grep -qiE "hit your limit|API Error|ConnectionRefused|unable to connect"; then
            echo "  API still unavailable. Waiting another 5 minutes..."
        else
            echo "  API recovered. Retrying ${#FAILED_RETRY_IDS[@]} auditors..."
            break
        fi
    done

    # Clean up error markers from previous attempt
    for id in "${FAILED_RETRY_IDS[@]}"; do
        rm -f "$OUTPUT_DIR/${id}_error.txt"
    done

    # Run failed auditors with parallel pool
    declare -A RETRY_PIDS=()
    RETRY_NEXT=0
    RETRY_TOTAL=${#FAILED_RETRY_IDS[@]}

    for ((i = 0; i < MAX_PARALLEL && i < RETRY_TOTAL; i++)); do
        idx=$RETRY_NEXT
        RETRY_NEXT=$((RETRY_NEXT + 1))
        run_auditor "${FAILED_RETRY_IDS[$idx]}" "${FAILED_RETRY_PROMPTS[$idx]}" "${FAILED_RETRY_OUTPUTS[$idx]}" &
        RETRY_PIDS[$!]="${FAILED_RETRY_IDS[$idx]}"
        echo "  [${FAILED_RETRY_IDS[$idx]}] Retry started (pid $!)"
    done

    while [[ ${#RETRY_PIDS[@]} -gt 0 ]]; do
        wait -n 2>/dev/null || true
        for pid in "${!RETRY_PIDS[@]}"; do
            if ! kill -0 "$pid" 2>/dev/null; then
                id="${RETRY_PIDS[$pid]}"
                unset "RETRY_PIDS[$pid]"
                output_file="$OUTPUT_DIR/${id}.txt"
                if [[ -f "$output_file" ]] && [[ -s "$output_file" ]]; then
                    echo "  [${id}] Retry succeeded"
                else
                    echo "  [${id}] Retry failed"
                fi
                if [[ $RETRY_NEXT -lt $RETRY_TOTAL ]]; then
                    idx=$RETRY_NEXT
                    RETRY_NEXT=$((RETRY_NEXT + 1))
                    run_auditor "${FAILED_RETRY_IDS[$idx]}" "${FAILED_RETRY_PROMPTS[$idx]}" "${FAILED_RETRY_OUTPUTS[$idx]}" &
                    RETRY_PIDS[$!]="${FAILED_RETRY_IDS[$idx]}"
                    echo "  [${FAILED_RETRY_IDS[$idx]}] Retry started (pid $!)"
                fi
            fi
        done
        sleep 2
    done
done

echo ""
echo "Aggregating results..."
echo ""

# --- Aggregation ---

TOTAL_EARNED=0
TOTAL_POSSIBLE=0

echo "Category Results:"
for letter in A B C D E F G H I J K L M N O P Q R S T U V W; do
    output_file="$OUTPUT_DIR/${letter}.txt"
    if [[ -f "$output_file" ]] && [[ -s "$output_file" ]]; then
        earned="$(grep -oP 'EARNED:\s*\K[0-9]+' "$output_file" | tail -1)" || earned=0
        possible="$(grep -oP 'POSSIBLE:\s*\K[0-9]+' "$output_file" | tail -1)" || possible=0
        TOTAL_EARNED=$((TOTAL_EARNED + earned))
        TOTAL_POSSIBLE=$((TOTAL_POSSIBLE + possible))
        echo "  [${letter}] ${earned}/${possible}"
    elif [[ -f "$OUTPUT_DIR/${letter}_error.txt" ]]; then
        echo "  [${letter}] ERROR"
    else
        echo "  [${letter}] SKIP"
    fi
done

echo ""

SENTINEL_PASSED=0
SENTINEL_FAILED=0
SENTINEL_NA=0
FAILED_SENTINELS="none"

sentinel_output="$OUTPUT_DIR/sentinels.txt"
if [[ -f "$sentinel_output" ]] && [[ -s "$sentinel_output" ]]; then
    SENTINEL_PASSED="$(grep -oP 'PASSED:\s*\K[0-9]+' "$sentinel_output" | tail -1)" || SENTINEL_PASSED=0
    SENTINEL_FAILED="$(grep -oP 'FAILED:\s*\K[0-9]+' "$sentinel_output" | tail -1)" || SENTINEL_FAILED=0
    SENTINEL_NA="$(grep -oP 'NA:\s*\K[0-9]+' "$sentinel_output" | tail -1)" || SENTINEL_NA=0
    FAILED_SENTINELS="$(grep -oP 'FAILED_IDS:\s*\K.*' "$sentinel_output" | tail -1)" || FAILED_SENTINELS="none"
    echo "Sentinels: ${SENTINEL_PASSED} pass, ${SENTINEL_FAILED} fail, ${SENTINEL_NA} n/a"
elif [[ -f "$OUTPUT_DIR/sentinels_error.txt" ]]; then
    echo "Sentinels: ERROR"
else
    echo "Sentinels: SKIP"
fi

echo ""

# Compute aggregate
if [[ "$TOTAL_POSSIBLE" -gt 0 ]]; then
    PERCENTAGE=$(awk "BEGIN { printf \"%.1f\", ($TOTAL_EARNED / $TOTAL_POSSIBLE) * 100 }")
else
    PERCENTAGE="0.0"
fi

# Write summary
SUMMARY="AUDIT SUMMARY
=============
Game: $GAME_PATH
Model: $MODEL
Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)

CRITERIA SCORE: ${TOTAL_EARNED}/${TOTAL_POSSIBLE} (${PERCENTAGE}%)
SENTINEL PASS: ${SENTINEL_PASSED}
SENTINEL FAIL: ${SENTINEL_FAILED}
SENTINEL N/A:  ${SENTINEL_NA}
FAILED SENTINELS: ${FAILED_SENTINELS}

SCORE: ${PERCENTAGE}"

echo "$SUMMARY"
echo "$SUMMARY" > "$OUTPUT_DIR/summary.txt"

# Clean up any leftover tmux sessions from auditors
for id in "${JOB_IDS[@]}"; do
    tmux kill-session -t "audit-${id}" 2>/dev/null || true
done

echo ""
echo "Full outputs saved to: $OUTPUT_DIR"
