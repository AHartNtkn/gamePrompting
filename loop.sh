#!/usr/bin/env bash
set -euo pipefail

# Autoresearch loop for game creation prompt optimization.
# Each iteration: analyze → modify → generate → audit → evaluate → keep/discard
# Each step uses a fresh claude context. The journal is persistent state.
#
# Usage: ./loop.sh [--model MODEL] [--iterations N]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JOURNAL="$SCRIPT_DIR/journal.md"
RESULTS="$SCRIPT_DIR/results.tsv"
GENERATOR_DIR="$SCRIPT_DIR/generator"
AUDITOR_DIR="$SCRIPT_DIR/auditor"
LOG_DIR="$SCRIPT_DIR/logs"

MODEL="sonnet"
MAX_ITERATIONS=0  # 0 = infinite
SKIP_TO=""        # resume point: "audit", "evaluate", "loop"

while [[ $# -gt 0 ]]; do
    case $1 in
        --model) MODEL="$2"; shift 2 ;;
        --iterations|-n) MAX_ITERATIONS="$2"; shift 2 ;;
        --skip-to) SKIP_TO="$2"; shift 2 ;;
        *) echo "Unknown argument: $1" >&2; exit 1 ;;
    esac
done

# --- Logging ---
# log() prints to terminal and appends to log file.
# run_live() runs a command, logs full output, shows only the latest
# non-empty line on the terminal (overwriting in place).

mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/loop-$(date -u +%Y%m%d-%H%M%S).log"

log() {
    local timestamp
    timestamp="$(date -u +%H:%M:%S)"
    echo "[$timestamp] $*"
    echo "[$timestamp] $*" >> "$LOG_FILE"
}

# Run a claude -p call with stream-json, showing filtered output in place via /dev/tty.
# Full stream-json is saved to logfile. Terminal shows a single updating status line.
# Args: logfile prompt [extra claude args...]
run_claude() {
    local logfile="$1"
    local prompt="$2"
    shift 2

    # Write prompt to temp file to avoid "Argument list too long"
    local prompt_tmp
    prompt_tmp=$(mktemp)
    echo "$prompt" > "$prompt_tmp"

    claude -p - "$@" \
        --output-format stream-json --verbose \
        < "$prompt_tmp" \
        2>&1 | tee "$logfile" | jq -c --unbuffered 'del(.session_id, .uuid, .timestamp, .parent_tool_use_id, .rate_limit_info, .mcp_servers, .slash_commands, .apiKeySource, .claude_code_version, .output_style, .agents, .skills, .plugins, .fast_mode_state, .permissionMode, .modelUsage, .permission_denials, .message.model, .message.id, .message.usage, .message.stop_reason, .message.stop_sequence, .message.context_management, .tool_use_result, .total_cost_usd, .usage, .duration_ms, .duration_api_ms)' 2>/dev/null | cut -c1-200 || true

    rm -f "$prompt_tmp"
}

# --- Initialization ---

# Kill orphaned tmux sessions from previous runs.
# Game processes in tmux survive loop termination and can recreate
# deleted directories or hold file descriptors open.
for sess in $(tmux list-sessions -F '#{session_name}' 2>/dev/null); do
    if [[ "$sess" == game* || "$sess" == audit-* ]]; then
        tmux kill-session -t "$sess" 2>/dev/null
        log "Killed orphaned tmux session: $sess"
    fi
done

if [[ ! -f "$JOURNAL" ]]; then
    cat > "$JOURNAL" << 'JOURNAL_EOF'
# Research Journal

## Patterns Observed

(No iterations completed yet.)

## Ideas Backlog

(No ideas yet — will be populated after the first audit.)

## Dead Ends

(Nothing tried yet.)

## Iteration Log

(Entries will be appended after each iteration.)
JOURNAL_EOF
    log "Created journal.md"
fi

if [[ ! -f "$RESULTS" ]]; then
    printf 'commit\tconcept\tscore\tsentinel_pass\tsentinel_fail\tstatus\tdescription\n' > "$RESULTS"
    log "Created results.tsv"
fi

# --- Helper: get best score for a concept ---

best_score_for_concept() {
    local concept="$1"
    awk -F'\t' -v c="$concept" '
        NR > 1 && $2 == c && $6 == "keep" { if ($3 > best) best = $3 }
        END { print (best ? best : "0") }
    ' "$RESULTS"
}

# --- Helper: count completed iterations ---

completed_iterations() {
    tail -n +2 "$RESULTS" | wc -l | tr -d ' '
}

# --- Baseline Run ---
# On first launch (no results yet), run a baseline: generate + audit
# the current prompt without modifications, so the journal and scores
# have real data before the first modification attempt.

if [[ $(completed_iterations) -eq 0 && "$SKIP_TO" != "loop" ]]; then
    log "========================================"
    log "  Baseline Run"
    log "========================================"

    CONCEPT=1

    if [[ "$SKIP_TO" == "audit" || "$SKIP_TO" == "evaluate" ]]; then
        log "  Skipping generation (--skip-to $SKIP_TO)"
    else
        log "  Generating baseline game for concept $CONCEPT..."
        timeout 3600 ./generate.sh "$CONCEPT" --model "$MODEL" 2>&1 | tee run.log || true
    fi

    # Check for game by looking for run.sh, not exit codes
    GAME_DIR=$(ls -dt "$SCRIPT_DIR/games"/*/ 2>/dev/null | head -1)
    if [[ -z "$GAME_DIR" || ! -f "$GAME_DIR/run.sh" ]]; then
        log "  ERROR: No game produced for baseline."
        printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
            "$(git rev-parse --short HEAD)" "$CONCEPT" "0" "0" "0" "error" "baseline: no game produced" \
            >> "$RESULTS"
        log ""
        # Continue to main loop anyway
    else
        log "  Game found: $GAME_DIR"

        if [[ "$SKIP_TO" == "evaluate" ]]; then
            log "  Skipping audit (--skip-to evaluate)"
        else
            log "  Auditing baseline game..."
            timeout 7200 ./audit.sh "$GAME_DIR" --model "$MODEL" 2>&1 | tee audit.log || true
        fi

        AUDIT_DIR=$(ls -dt "$SCRIPT_DIR/audits"/*/ 2>/dev/null | head -1)
        if [[ -z "$AUDIT_DIR" || ! -f "$AUDIT_DIR/summary.txt" ]]; then
            log "  ERROR: No audit summary found for baseline."
            printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
                "$(git rev-parse --short HEAD)" "$CONCEPT" "0" "0" "0" "error" "baseline: no audit summary" \
                >> "$RESULTS"
        else
            SCORE=$(grep -oP 'SCORE:\s*\K[\d.]+' "$AUDIT_DIR/summary.txt" | tail -1) || SCORE="0"
            SENTINEL_PASS=$(grep -oP 'SENTINEL PASS:\s*\K\d+' "$AUDIT_DIR/summary.txt" | tail -1) || SENTINEL_PASS="0"
            SENTINEL_FAIL=$(grep -oP 'SENTINEL FAIL:\s*\K\d+' "$AUDIT_DIR/summary.txt" | tail -1) || SENTINEL_FAIL="0"

            log "  Baseline score: $SCORE"
            log "  Sentinels: $SENTINEL_PASS pass, $SENTINEL_FAIL fail"

            printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
                "$(git rev-parse --short HEAD)" "$CONCEPT" "$SCORE" "$SENTINEL_PASS" "$SENTINEL_FAIL" "keep" "baseline" \
                >> "$RESULTS"

            # Run evaluator to populate journal from baseline audit
            log "  Populating journal from baseline audit..."
            FULL_AUDIT=""
            for f in "$AUDIT_DIR"/*.txt; do
                fname=$(basename "$f")
                FULL_AUDIT="${FULL_AUDIT}
### $fname
$(cat "$f")
"
            done

            EVALUATE_PROMPT="You are the evaluator in an autoresearch loop. A baseline iteration just completed — the game creation prompt was used without modifications. Your job is to analyze the results and populate the research journal.

## Baseline Results

Concept: $CONCEPT
Score: $SCORE
Sentinel passes: $SENTINEL_PASS
Sentinel failures: $SENTINEL_FAIL

## Full Audit Output
$FULL_AUDIT

## Instructions

Write the journal file at $JOURNAL. The journal has four sections:

1. **Patterns Observed** — what patterns do you see in the audit feedback? What are the prompt's current strengths and weaknesses?
2. **Ideas Backlog** — based on the audit feedback, what changes to the game creation prompt or agents would most improve scores? Rank by expected impact. Be specific and actionable.
3. **Dead Ends** — (empty for now, nothing has been tried yet)
4. **Iteration Log** — record the baseline: concept, score, key observations.

Be specific and actionable. 'Improve combat' is useless. 'Add per-weapon range effectiveness tables to the prompt so the generator creates distinct weapon identities' is useful.

Write the updated journal to $JOURNAL using the Write tool. Output nothing else."

            run_claude "$LOG_DIR/evaluate-baseline.log" "$EVALUATE_PROMPT" \
                --model "$MODEL" \
                --tools "Read,Write" \
                --permission-mode bypassPermissions \
                || true

            log "  Baseline complete. Journal populated."
        fi
    fi

    log ""
fi

# --- Main Loop ---

log "========================================"
log "  Autoresearch Loop"
log "  Model: $MODEL"
log "  Iterations: $([ "$MAX_ITERATIONS" -eq 0 ] && echo "unlimited" || echo "$MAX_ITERATIONS")"
log "========================================"
log ""

while true; do
    ITERATION=$(($(completed_iterations) + 1))
    CONCEPT=$(( ((ITERATION - 1) % 5) + 1 ))
    BEST_SCORE=$(best_score_for_concept "$CONCEPT")

    log "========================================"
    log "  Iteration $ITERATION — Concept $CONCEPT"
    log "  Best score for concept $CONCEPT: $BEST_SCORE"
    log "========================================"

    # Save the current commit so we can revert on discard
    BEFORE_COMMIT=$(git rev-parse HEAD)
    log "Starting from commit $BEFORE_COMMIT"

    # ------------------------------------------------------------------
    # Step 1: ANALYZE + MODIFY
    # Claude reads the journal, results, and recent audit feedback,
    # then modifies generator files. Commits the changes.
    # ------------------------------------------------------------------

    if [[ "$SKIP_TO" == "audit" || "$SKIP_TO" == "evaluate" ]]; then
        log "[Step 1] SKIPPED (--skip-to $SKIP_TO)"
        THESIS_TEXT="(skipped — resuming from existing state)"
    else

    log "[Step 1] Analyzing feedback and modifying generator..."

    # Collect recent audit outputs for context (most recent audit directory)
    LATEST_AUDIT=""
    AUDIT_CONTEXT=""
    if [[ -d "$SCRIPT_DIR/audits" ]]; then
        LATEST_AUDIT=$(ls -dt "$SCRIPT_DIR/audits"/*/ 2>/dev/null | head -1)
        if [[ -n "$LATEST_AUDIT" && -f "$LATEST_AUDIT/summary.txt" ]]; then
            AUDIT_CONTEXT="## Most Recent Audit Results

$(cat "$LATEST_AUDIT/summary.txt")

### Category Details (excerpts)
"
            # Include the scoring lines from each category output
            for f in "$LATEST_AUDIT"/*.txt; do
                fname=$(basename "$f")
                if [[ "$fname" != "summary.txt" ]]; then
                    scores=$(grep -E '^[A-Z][0-9]+:|^S[0-9]+:|^EARNED:|^POSSIBLE:|^PASSED:|^FAILED:|^CATEGORY:' "$f" 2>/dev/null || true)
                    if [[ -n "$scores" ]]; then
                        AUDIT_CONTEXT="${AUDIT_CONTEXT}
#### $fname
$scores
"
                    fi
                fi
            done
        fi
    fi

    MODIFY_PROMPT="You are the research agent in an autoresearch loop optimizing a game creation prompt. Your goal is to modify the generator files so that games produced by the prompt score higher on the audit.

## Current State

Iteration: $ITERATION
Concept for this iteration: $CONCEPT (see test-prompts.md for the description)
Best score for concept $CONCEPT so far: $BEST_SCORE

## Journal
$(cat "$JOURNAL")

## Results History
$(cat "$RESULTS")

${AUDIT_CONTEXT}

## Instructions

### Step 1: Architecture Review (do this FIRST, every iteration)

Before considering any specific change, evaluate the current generator ARCHITECTURE:

- Read all files under generator/ (the main prompt and any reference files) and .claude/agents/ (agent definitions). Also check .claude/commands/ and .claude/skills/ if they exist.
- Ask: is the current structure the right structure? Consider:
  - Should any section of the main prompt be extracted into a separate agent that runs as a verification pass?
  - Are there failure patterns recurring across iterations that would be better caught by a NEW agent than by more text in the existing prompt?
  - Is the main prompt getting too long? Would splitting it (e.g., separate design-phase and implementation-phase prompts, or genre-specific guidance files) improve focus?
  - Are the existing agents underutilized? Would changing their instructions, adding new tools, or restructuring when they run in the pipeline have more impact than adding rules?
  - Would a new file (e.g., a reference document with concrete examples, a checklist the generator loads, a formula library) serve better than inline instructions?
  - Would a custom skill help? Use /skill-creator to create reusable skills that the generator or its agents can invoke. Skills are good for repeatable multi-step procedures (e.g., a balance-testing protocol, a UI review checklist, a simulation-verification workflow).

Write your architectural assessment in your thinking. If the current architecture is adequate, say so and explain why. If it isn't, restructure BEFORE making content changes.

**The default is to consider structural change.** Adding more paragraphs to game-creation-prompt.md is the LAST resort, not the first. Every iteration that just appends enforcement text to an already-long prompt is a missed opportunity to improve the system's architecture.

### Step 2: Form a thesis

Based on the journal, audit feedback, and your architectural assessment:
- What is the highest-leverage change you can make this iteration?
- Is it a structural change (new agent, restructured pipeline, extracted reference doc) or a content change (revised instructions, new examples, stronger guidance)?
- Why is this the right level of intervention — why wouldn't a simpler or more ambitious change work better?

### Step 3: Implement

You have full control over:
- **generator/** — the main prompt and any reference files
- **.claude/agents/** — agent definitions (play-tester, balance-checker, design-reviewer, system-implementer, plus any new agents you create). These are automatically available to the generator when it spawns sub-agents.
- **.claude/commands/** — custom slash commands available to the generator
- **.claude/skills/** — custom skills available to the generator

You can:
- Edit, create, delete, rename, or restructure any files in these locations
- Create new agents that address specific failure classes
- Split the main prompt into multiple files or reference documents
- Add example libraries, checklists, formula references
- Change how agents interact and when they're invoked

### Step 4: Commit and report

Commit your changes with a descriptive message explaining your thesis.
Output a single line at the very end: THESIS: <one-sentence summary of what you changed and why>

Do NOT generate or audit a game. Only modify the generator files and commit."

    MODIFY_LOG="$LOG_DIR/modify-iter${ITERATION}.log"
    run_claude "$MODIFY_LOG" "$MODIFY_PROMPT" \
        --model "$MODEL" \
        --tools "Bash,Read,Write,Edit,Glob,Grep" \
        --permission-mode bypassPermissions \
        --add-dir "$GENERATOR_DIR" \
        || true

    THESIS=$(jq -r 'select(.type=="result") | .result // empty' "$MODIFY_LOG" 2>/dev/null | grep '^THESIS:' | tail -1) || THESIS=""
    if [[ -z "$THESIS" ]]; then
        THESIS="THESIS: (no thesis captured)"
    fi
    THESIS_TEXT="${THESIS#THESIS: }"

    log "  $THESIS"

    # Check if anything was actually committed
    AFTER_MODIFY_COMMIT=$(git rev-parse HEAD)
    if [[ "$BEFORE_COMMIT" == "$AFTER_MODIFY_COMMIT" ]]; then
        log "  WARNING: No changes committed. Skipping this iteration."
        printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
            "$(git rev-parse --short HEAD)" "$CONCEPT" "0" "0" "0" "error" "no changes made" \
            >> "$RESULTS"
        continue
    fi

    fi  # end skip-to check for modify step

    # ------------------------------------------------------------------
    # Step 2: GENERATE
    # ------------------------------------------------------------------

    if [[ "$SKIP_TO" == "audit" || "$SKIP_TO" == "evaluate" ]]; then
        log "[Step 2] SKIPPED (--skip-to $SKIP_TO)"
    else
        log "[Step 2] Generating game for concept $CONCEPT..."
        timeout 3600 ./generate.sh "$CONCEPT" --model "$MODEL" 2>&1 | tee run.log || true
    fi

    # Check for game by looking for run.sh, not exit codes
    GAME_DIR=$(ls -dt "$SCRIPT_DIR/games"/*/ 2>/dev/null | head -1)
    if [[ -z "$GAME_DIR" || ! -f "$GAME_DIR/run.sh" ]]; then
        log "  ERROR: No game produced (no run.sh found)."
        printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
            "$(git rev-parse --short HEAD)" "$CONCEPT" "0" "0" "0" "error" "no game produced: $THESIS_TEXT" \
            >> "$RESULTS"
        git reset --hard "$BEFORE_COMMIT" 2>/dev/null
        log "  Reverted to $BEFORE_COMMIT"
        continue
    fi

    log "  Game generated: $GAME_DIR"

    # ------------------------------------------------------------------
    # Step 3: AUDIT
    # ------------------------------------------------------------------

    if [[ "$SKIP_TO" == "evaluate" ]]; then
        log "[Step 3] SKIPPED (--skip-to evaluate)"
    else
        log "[Step 3] Auditing game..."
        timeout 7200 ./audit.sh "$GAME_DIR" --model "$MODEL" 2>&1 | tee audit.log || true
    fi

    # Check for audit summary, not exit codes
    AUDIT_DIR=$(ls -dt "$SCRIPT_DIR/audits"/*/ 2>/dev/null | head -1)
    if [[ -z "$AUDIT_DIR" || ! -f "$AUDIT_DIR/summary.txt" ]]; then
        log "  ERROR: No audit summary found."
        printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
            "$(git rev-parse --short HEAD)" "$CONCEPT" "0" "0" "0" "error" "no audit summary: $THESIS_TEXT" \
            >> "$RESULTS"
        git reset --hard "$BEFORE_COMMIT" 2>/dev/null
        log "  Reverted to $BEFORE_COMMIT"
        continue
    fi

    log "  Audit complete: $AUDIT_DIR"

    # Extract scores
    SCORE=$(grep -oP 'SCORE:\s*\K[\d.]+' "$AUDIT_DIR/summary.txt" | tail -1) || SCORE="0"
    SENTINEL_PASS=$(grep -oP 'SENTINEL PASS:\s*\K\d+' "$AUDIT_DIR/summary.txt" | tail -1) || SENTINEL_PASS="0"
    SENTINEL_FAIL=$(grep -oP 'SENTINEL FAIL:\s*\K\d+' "$AUDIT_DIR/summary.txt" | tail -1) || SENTINEL_FAIL="0"
    FAILED_IDS=$(grep -oP 'FAILED SENTINELS:\s*\K.*' "$AUDIT_DIR/summary.txt" | tail -1) || FAILED_IDS="none"

    log "  Score: $SCORE (best: $BEST_SCORE)"
    log "  Sentinels: $SENTINEL_PASS pass, $SENTINEL_FAIL fail"
    log "  Failed sentinels: $FAILED_IDS"

    # ------------------------------------------------------------------
    # Step 4: EVALUATE + UPDATE JOURNAL
    # Claude reads the audit results and updates the journal.
    # ------------------------------------------------------------------

    log "[Step 4] Evaluating results and updating journal..."

    # Collect full audit details for the evaluator
    FULL_AUDIT=""
    for f in "$AUDIT_DIR"/*.txt; do
        fname=$(basename "$f")
        FULL_AUDIT="${FULL_AUDIT}
### $fname
$(cat "$f")
"
    done

    EVALUATE_PROMPT="You are the evaluator in an autoresearch loop. An iteration just completed. Your job is to analyze the results and update the research journal.

## Iteration $ITERATION Results

Concept: $CONCEPT
Score: $SCORE
Best score for concept $CONCEPT: $BEST_SCORE
Sentinel passes: $SENTINEL_PASS
Sentinel failures: $SENTINEL_FAIL
Thesis: $THESIS_TEXT

## Full Audit Output
$FULL_AUDIT

## Current Journal
$(cat "$JOURNAL")

## Results History
$(cat "$RESULTS")

## Instructions

Update the journal file at $JOURNAL. The journal has four sections:

1. **Patterns Observed** — recurring themes across iterations. Update this with any new patterns you see. Remove patterns that are no longer relevant.
2. **Ideas Backlog** — things worth trying in future iterations, ranked by expected impact. Add new ideas based on the audit feedback. Remove ideas that were tried (whether they worked or not). This is the most important section — it's what the next iteration's modify step reads to decide what to do.
3. **Dead Ends** — approaches that were tried and didn't help. Keep this concise. The point is to avoid repeating failed approaches.
4. **Iteration Log** — append a brief entry for this iteration: what was tried, what the score was, what the key takeaways were.

Be specific and actionable. 'Improve combat' is useless. 'Add per-weapon range effectiveness tables to the prompt so the generator creates distinct weapon identities' is useful.

Write the updated journal to $JOURNAL using the Write tool. Output nothing else."

    EVAL_LOG="$LOG_DIR/evaluate-iter${ITERATION}.log"
    run_claude "$EVAL_LOG" "$EVALUATE_PROMPT" \
        --model "$MODEL" \
        --tools "Read,Write" \
        --permission-mode bypassPermissions \
        || true

    # ------------------------------------------------------------------
    # Step 5: KEEP OR DISCARD
    # ------------------------------------------------------------------

    IMPROVED=$(awk "BEGIN { print ($SCORE > $BEST_SCORE) ? \"yes\" : \"no\" }")

    if [[ "$IMPROVED" == "yes" ]]; then
        STATUS="keep"
        log "  KEEP — score improved ($BEST_SCORE → $SCORE)"
    else
        STATUS="discard"
        log "  DISCARD — score did not improve ($SCORE <= $BEST_SCORE)"
        git reset --hard "$BEFORE_COMMIT" 2>/dev/null
        log "  Reverted to $BEFORE_COMMIT"
    fi

    # Log to results.tsv
    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
        "$(git rev-parse --short HEAD)" "$CONCEPT" "$SCORE" "$SENTINEL_PASS" "$SENTINEL_FAIL" "$STATUS" "$THESIS_TEXT" \
        >> "$RESULTS"

    # Clear skip-to after first iteration so subsequent iterations run fully
    SKIP_TO=""

    log "  Iteration $ITERATION complete."
    log ""

    # Check iteration limit
    if [[ "$MAX_ITERATIONS" -gt 0 && "$ITERATION" -ge "$MAX_ITERATIONS" ]]; then
        log "Reached $MAX_ITERATIONS iterations. Stopping."
        break
    fi
done

echo ""
echo "========================================"
echo "  Loop complete. Results in results.tsv"
echo "========================================"
