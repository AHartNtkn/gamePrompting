# CLAUDE.md

## Project Goal

Refine a game creation prompt through automated evaluation. The core artifacts are **auditor prompts** that score LLM-generated CLI games on design quality, producing numerical scores used by an autoresearch loop.

## Key Files

- `CONCEPT.md` — Design philosophy, scoring approach, anti-bias strategy. **Keep this updated** as decisions are made or revised.
- `test-prompts.md` — The 5 fixed game concepts used for every loop iteration.
- `generate.sh` — Creates a game from a concept using the game creation prompt.
- `audit.sh` — Runs all auditor prompts against a game and aggregates scores.
- `generator/game-creation-prompt.md` — The game creation prompt (what autoresearch optimizes).
- `auditor/criteria-catalog.md` — 212 evaluable game design criteria from 17+ frameworks.
- `auditor/sentinel-catalog.md` — 58 LLM-specific and template-design failure mode detectors.
- `auditor/shared-preamble.md` — Common evaluation framework concatenated with each category prompt.
- `auditor/prompts/A.md` through `U.md` — 21 category auditor prompts with specific evaluation instructions.
- `auditor/prompts/sentinels.md` — Sentinel check prompt (binary pass/fail).
- `auditor/research-criteria.md` — Raw research output (reference only, not a deliverable).

## NEVER DELETE GENERATED GAMES OR AUDIT OUTPUTS

Do not delete files in `games/` or `audits/`. These are generated artifacts that may take significant time and cost to reproduce. Updating prompts or tooling does not require deleting existing outputs. If old outputs don't conform to new requirements, leave them and generate new ones alongside them.

## Interactive Play Protocol

Both the game creator (during self-testing) and the auditor must **actually play** games interactively. This means turn-by-turn interaction where each command is decided after reading the game's previous output. **Piping pre-scripted inputs is banned.**

The method uses **tmux** for interactive play. The Bash tool is stateless between calls (shell state like file descriptors does not persist), so named pipes don't work. Tmux provides a persistent terminal session that survives across bash calls.

1. Start the game in a tmux session:
   ```bash
   tmux kill-session -t game 2>/dev/null
   tmux new-session -d -s game -x 120 -y 40 'cd GAME_DIR && python3 -u game.py'
   sleep 1
   ```

2. Read the game's output (each read is a separate bash tool call):
   ```bash
   tmux capture-pane -t game -p
   ```

3. Think about what the output shows. Decide next action.

4. Send ONE command:
   ```bash
   tmux send-keys -t game 'your command' Enter
   ```

5. Read the response (separate bash call). Repeat from step 3.
   ```bash
   sleep 1 && tmux capture-pane -t game -p
   ```

Each step is a separate tool call. The agent reads output, reasons about it in between calls, and decides the next command. This is genuine interactive play.

Cleanup when done:
```bash
tmux kill-session -t game 2>/dev/null
```

Games do NOT need special architecture to support this. A normal interactive CLI game using `input()` and `print()` works with tmux. The only requirement is unbuffered output (`python3 -u`).

## Instructions

- When the user communicates new decisions, preferences, or design changes, update `CONCEPT.md` to reflect them.
- The auditor evaluates **game design execution**, not concept quality, code quality, or tutorial quality.
- All games under evaluation are CLI-based interactive simulations (strategy, roguelike, management, tactical). They are open-ended, mechanics-first, and aimed at experienced gamers.
- The auditor must resist positivity bias. Its structure enforces flaw-first analysis, evidence requirements, and adversarial self-review.
- The criteria catalog is intentionally comprehensive and unfiltered. Do not pre-filter or trim it. Refinement happens through testing, not through guessing what matters.
- The auditor is split across multiple prompts for **attention management** — each prompt focuses on a small coherent subset so it can evaluate deeply. This is not organizational; it directly affects evaluation quality.
- Some criteria exist not because they're universal game design wisdom, but because they detect common LLM game-generation failure modes ("sentinel criteria"). These are valuable even if they'd be arbitrary applied to human games.
- Remove criteria that prove to be noise rather than down-weighting them.

## Orphaned tmux Sessions

Games are play-tested in tmux sessions (named `game`, `audit-*`, etc.). If the loop or generator is killed mid-run, the tmux session survives — the game process keeps running in the background. This causes a hard-to-debug problem: `rm -rf` on the game directory appears to succeed, but the running process can recreate files or hold open file descriptors that prevent full deletion. The directory reappears with no obvious cause.

**Always kill tmux sessions before deleting game directories.** `tmux kill-server` or `tmux kill-session -t game` before `rm -rf games/*`. `loop.sh` kills orphaned sessions on startup.

## Git Workflow

This is a git repository. Commit after changes to prompts, catalogs, or tooling. Games and audits are generated artifacts — they are archived to `~/Documents/gameArchive/` and `~/Documents/auditArchive/` respectively and are NOT tracked in git (listed in `.gitignore`).
