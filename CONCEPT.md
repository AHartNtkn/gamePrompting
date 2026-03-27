# Game Creation Prompt Refinement

## Overview

This project uses an [autoresearch](https://github.com/karpathy/autoresearch) loop to iteratively refine a **game creation prompt** — a prompt given to an LLM agent that produces CLI-based interactive simulations (strategy games, roguelikes, management sims, tactical games, etc.).

The loop works as follows:
1. A **game creation prompt** is used to generate several games across different concepts.
2. Each generated game is evaluated by an **auditor** multiple times.
3. The aggregate scores provide signal on prompt quality.
4. The autoresearch loop uses this signal to refine the prompt.

Five scores on five projects yields 25 data points per iteration — enough for a strong signal.

## Why CLI Games

CLI games (with optional ASCII graphics) have two properties that make them ideal for LLM-generated games:

1. **Abstraction leverages imagination.** The player fills in visuals. The game's job is to communicate *what to imagine* through concrete descriptions, ASCII art, or both. The game provides coherence; the player provides rendering.

2. **Unlimited simulation fidelity.** Without graphics to render, world state can be any combination of combinatorial objects. This enables the kind of deep simulation seen in games like Dwarf Fortress, Warsim, or Caves of Qud.

## Design Philosophy

### What We're Evaluating

We evaluate **game design execution**, not:
- The concept/idea (that comes from the user, not the prompt)
- Code quality (implementation concern, not design concern)
- Tutorial quality (separable from the game itself)
- Literary quality (these are games, not interactive fiction)

### What Makes a Good Game

These are interactive simulations aimed at **experienced gamers**. The question is: once the mechanics are mastered, does the game provide an engaging, deep experience?

Core beliefs:
- **Depth over polish.** But unfinished mechanics are flaws — depth means *completed* depth.
- **Mechanics first.** Plot, lore, and flavor can be layered on later. The foundation must be a system that is *fun to play*.
- **Simulation coherence.** Rules must be consistent and predictable. Surprise should come from emergent interactions, not arbitrary events.
- **Information management over information density.** Verbose descriptions are fine in context (examining an object). The player must never be overwhelmed or confused about what to pay attention to.
- **Replayability is intrinsic.** Open-ended simulations necessarily have variety of experience as a core factor.
- **Genre-agnostic, deontological evaluation.** Judge what the game *tried* to accomplish, mixed with universal design criteria.

## The Auditor

### Criteria Catalog

The auditor is grounded in a comprehensive catalog of 212 evaluable criteria (`auditor/criteria-catalog.md`), deduplicated from ~407 raw criteria across 17+ game design frameworks (MDA, Schell's Lenses, Salen/Zimmerman, Costikyan, Koster, Burgun, Csikszentmihalyi Flow Theory, PENS, GEQ, GameFlow, Berlin Interpretation, and others) plus 15 criteria identified from a player-experience research gap — design qualities widely cited by experienced players but absent from all standard frameworks.

The catalog is the reference. The auditor prompts draw from it, but not every criterion is scored in every evaluation. Criteria that prove to be noise should be removed from the catalog rather than down-weighted.

### Multi-Prompt Architecture

The auditor is split across multiple prompts. This is not an organizational convenience — it is an attention management strategy. An LLM evaluating 196 criteria in a single prompt will do a shallow job on all of them. Multiple focused prompts, each responsible for a coherent subset, can evaluate deeply within their domain. The aggregate score is computed from all prompts' outputs.

Each auditor prompt should:
- Focus on a small enough set of criteria that it can give each one genuine attention.
- Have a coherent domain so the evaluator can build and maintain context about that aspect of the game.
- Produce its own sub-score that gets combined into the aggregate.

Additionally, some criteria exist not because they're universal game design wisdom, but because they detect common LLM game-generation failure modes ("sentinel criteria"). These sacrifice a sliver of design space to head off specific patterns that correlate with lazy or broken output. (Inspired by diagram auditors that check for things like "lacks numbered items" — an arbitrary restriction that dramatically increases the likelihood of a good outcome by blocking a common failure mode.)

### Sentinel Criteria: LLM Failure Modes

LLM-generated games have failure modes that human-made games rarely have. The core problem is **trope reliance / autocomplete-like behavior** — the model reaches for the most statistically common pattern rather than reasoning about what would actually work. This manifests as "paint-by-numbers" design where every element follows the most obvious template.

A critical requirement is that the auditor (and ideally the game creation prompt itself) must **actually play the game** to detect gameplay-level failures. Many LLM failure modes look fine in source code but are immediately obvious during play — e.g., NPCs blocking player movement so severely that nothing can be accomplished, or combat that is technically present but functionally broken because the balance was never tested.

Known LLM-specific concerns:
- **Trope reliance** — defaulting to the most common game design patterns rather than reasoning about what fits
- **Untested gameplay** — systems that look correct in code but produce unplayable or degenerate dynamics
- **Missing player model** — no consideration of what the player actually experiences moment-to-moment (movement, pacing, information flow)

The full sentinel catalog is in `auditor/sentinel-catalog.md` — 58 concrete, checkable patterns across 10 domains. Many can be inverted into instructions for the game creation prompt itself.

### Anti-Bias Design

LLM evaluators have known biases (positivity bias, anchoring, order effects). The auditor counters these through:

1. **Flaw-first analysis** — For each category, the auditor must identify weaknesses before strengths.
2. **Evidence requirement** — Every score must cite a specific game element as justification.
3. **Calibrated anchors** — Each score level (0-5) has a concrete definition, not a vague adjective.
4. **Adversarial review** — After initial scoring, the auditor must argue why each score should be *lower*, then make final adjustments.
5. **Baseline expectation of 2** — A score of 3 means "meets expectations," not "average." The scale is anchored to prevent grade inflation.
6. **No partial credit for intent** — An unfinished feature scores as if it doesn't exist. Ambition that doesn't land is not rewarded.

### Scoring

The primary auditor produces a raw score. The sentinel checks produce pass/fail flags that may modify the score or provide context. The aggregate is the primary signal fed back to the autoresearch loop.

## File Structure

```
gamePrompting/
  CONCEPT.md                     — This file. Overall design and philosophy.
  CLAUDE.md                      — Goals and instructions for agents working here.
  test-prompts.md                — The 5 fixed game concepts used for every loop iteration.
  generate.sh                     — Creates a game from a concept using the game creation prompt.
  audit.sh                       — Runs all auditor prompts against a game and aggregates scores.
  generator/
    game-creation-prompt.md      — The game creation prompt (what autoresearch optimizes).
  auditor/
    shared-preamble.md           — Common evaluation framework (score anchors, anti-bias process).
    criteria-catalog.md          — 212 evaluable criteria (reference/source of truth).
    sentinel-catalog.md          — 58 LLM/template failure mode detectors (reference).
    research-criteria.md         — Raw research output (reference only).
    prompts/
      A.md through U.md          — 21 category auditor prompts with evaluation instructions.
      sentinels.md               — Sentinel check prompt (binary pass/fail).
```

## Auditor Prompt Structure

Each letter-category (A-U) in the criteria catalog becomes its own focused auditor prompt. No limit on the number of prompts — attention depth matters more than prompt count.

### Conditional Criteria and Scoring

Some criteria are conditional — they only apply if the game has the relevant feature (e.g., "if the game has an economy..." or "if ASCII art is used..."). When a criterion doesn't apply, it scores **N/A (0/0)**, not 0/5. This means the maximum possible score varies from game to game.

Aggregation must handle this:
- Final score is **sum of earned points / sum of applicable points**, expressed as a percentage or normalized score.
- Autoresearch must be made aware that N/A criteria cause the denominator to vary across games without saying anything about quality. Score differences driven by denominator changes are not signal.

### Research Gaps

The criteria catalog was built from established game design frameworks (MDA, Schell, Salen/Zimmerman, Costikyan, Koster, Burgun, etc.). These frameworks have blind spots — they tend to focus on what *designers* think about rather than what *players* feel. The "rule symmetry" criterion (players and NPCs operating under the same rules) was missing from all frameworks despite being widely cited as important in sim games and action games (Dark Souls, roguelikes, immersive sims). There are likely more criteria in this gap — things that experienced players recognize as important but that don't appear in design theory literature. These should be identified and added through player-perspective research, community discussion analysis, and empirical observation.

## Open Questions

- Are there more criteria hiding in the gap between design theory and player experience?
- What's the right normalization for scores with varying denominators?
- How should autoresearch interpret score variance across games with different applicable criteria?
- **Generator architecture:** The current game creation prompt enforces single-file, no-dependency, Python-default output. This is a bad anchor for optimization — the final version will likely be an orchestrator prompt managing a team of agents. The starting constraints shape the optimization trajectory; constraints that are too narrow will prevent the loop from discovering better architectures. This needs to be loosened before serious optimization begins.
