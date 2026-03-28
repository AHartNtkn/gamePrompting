# autoresearch — Game Creation Prompt Optimization

Autonomous loop that improves the game creation prompt by running generate→audit cycles. Modeled after [karpathy/autoresearch](https://github.com/karpathy/autoresearch).

## How It Works

`loop.sh` is the outer loop. Each iteration calls Claude with a fresh context for two steps:

1. **Analyze + Modify** — Claude reads the journal, results history, and audit feedback. It forms a thesis about what to change, modifies the generator files, and commits.
2. **Generate** — `generate.sh` creates a game from a test concept.
3. **Audit** — `audit.sh` runs all 22 category auditors + sentinel checks in parallel.
4. **Evaluate + Journal** — Claude reads the full audit output, updates the research journal with patterns, ideas, and dead ends.
5. **Keep/Discard** — if the score improved, keep the commit. Otherwise, `git reset --hard` to revert.

Each step gets a fresh context window. The journal (`journal.md`) is the persistent memory between iterations.

## Quick Start

```bash
# Create an experiment branch
git checkout -b autoresearch/mar27

# Run the loop (runs indefinitely until ctrl-c)
./loop.sh

# Or limit iterations
./loop.sh --iterations 10

# Use a different model
./loop.sh --model opus
```

## Files

| File | Purpose | Modified by |
|------|---------|-------------|
| `loop.sh` | Outer loop script | Human only |
| `journal.md` | Persistent research journal (untracked) | Evaluator agent |
| `results.tsv` | Score log (untracked) | loop.sh |
| `logs/loop-*.log` | Full timestamped logs (untracked) | loop.sh |
| `generator/**` | Game creation prompt + reference files | Research agent |
| `.claude/agents/` | Sub-agent definitions | Research agent |
| `.claude/commands/` | Custom slash commands | Research agent |
| `.claude/skills/` | Custom skills | Research agent |
| `auditor/**` | Evaluation standard | Nobody (read-only) |
| `test-prompts.md` | 5 fixed game concepts | Nobody (read-only) |

## What the Research Agent Can Change

Everything under `generator/` is fair game:

- Rewrite the game creation prompt
- Create, modify, delete, or restructure agent definitions
- Add reference files, examples, checklists
- Split the prompt into multiple files
- Any structural change that might improve audit scores

**Default to ambitious changes.** Each iteration is expensive (~1 hour). Micro-optimizations waste iterations.

## Concept Cycling

Iterations cycle through the 5 test concepts (1→2→3→4→5→1→...). The keep/discard decision compares against the best score *for that concept*, so improvements are tracked per-concept.

## The Journal

`journal.md` has four sections:

1. **Patterns Observed** — recurring themes across iterations
2. **Ideas Backlog** — ranked list of things to try next (most important section)
3. **Dead Ends** — approaches that didn't work
4. **Iteration Log** — what happened each iteration

The journal is updated by the evaluator agent after each iteration and read by the research agent before each modification.

## Logging

All loop output goes to both the terminal and `logs/loop-<timestamp>.log`. Individual step outputs go to `run.log` (generation) and `audit.log` (audit). Audit category outputs are saved in `audits/<game>_<timestamp>/`.
