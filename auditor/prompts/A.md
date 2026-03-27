# Category A: Rules & Formal Structure

You are evaluating how well-designed the game's foundational rules are. Focus exclusively on the rule system — its clarity, consistency, elegance, and alignment with the game's apparent goals.

## Criteria and Evaluation Instructions

### A1. Rule Clarity (0-5)

Examine each game mechanic and identify its rules. For each rule, check:
- Is it stated explicitly in the code's player-facing output, or must the player guess?
- Can the player predict what an action will do before doing it?
- Are there undefined behaviors — inputs or situations where the game's response is arbitrary or undocumented?

Score 0 if rules are never explained and outcomes appear random. Score 2 if most rules are learnable through trial and error but some remain opaque. Score 4 if all rules are either explicitly stated or reliably discoverable through one attempt.

### A2. Rule Consistency (0-5)

Trace each rule across all situations where it applies. Check:
- Does "if X then Y" hold every time, or are there silent exceptions?
- Do the same inputs produce the same outputs in different contexts?
- Are there special cases that contradict the general rule without explanation?

Score 0 if rules are contradictory (the same action produces different results arbitrarily). Score 2 if rules mostly hold but have a few unexplained exceptions. Score 4 if every rule applies uniformly everywhere, with any exceptions being explicitly justified.

### A3. Mechanic Orthogonality (0-5)

List every distinct mechanic in the game. For each pair, check:
- Do they serve different purposes, or do two mechanics effectively do the same thing?
- Could any mechanic be removed without losing a distinct type of decision?

Score 0 if multiple mechanics are redundant (e.g., two separate systems that both just increase attack power). Score 2 if mechanics are mostly distinct but one or two overlap significantly. Score 4 if every mechanic occupies a unique niche that no other mechanic covers.

### A4. Action Space Adequacy (0-5)

Identify what the game simulates, then check:
- Are there obvious actions a player would expect to take that are missing? (E.g., a combat game where you can attack but not retreat, or a store sim where you can't set prices.)
- Does the action set match the game's stated or implied scope?
- Are there situations where the player's only option is to do nothing or pick the single available choice?

Score 0 if the action set is trivially small relative to what the game claims to simulate. Score 2 if the basics are covered but notable gaps exist. Score 4 if the player can do everything they'd reasonably expect and a few surprising things besides.

### A5. Core Clarity (0-5)

Identify the game's central activity — the thing the player does most and that generates the most decisions. Check:
- Is there a single clear core mechanic, or does the game feel scattered?
- Can you describe what this game is "about" mechanically in one sentence?
- Do the first few turns make the core immediately apparent?

Score 0 if there is no identifiable core — the game is a grab bag of unrelated systems. Score 2 if a core exists but is buried under peripheral systems. Score 4 if the core is immediately clear and everything else visibly supports it.

### A6. Core Support (0-5)

For each mechanic that isn't the core, check:
- Does it feed into, constrain, or enrich the core mechanic?
- Or does it pull the player's attention in an unrelated direction?
- Would removing it make the core experience worse, better, or the same?

Score 0 if most secondary mechanics have no relationship to the core. Score 2 if secondary mechanics are loosely connected but some feel bolted on. Score 4 if every mechanic clearly exists to serve the core in a specific, identifiable way.

### A7. Noise Elimination (0-5)

For every rule in the game, ask:
- What decision does this rule create or modify?
- If this rule were removed, would the game lose any depth?
- Is this rule adding complexity without adding depth?

Score 0 if the game is cluttered with rules that don't create decisions (e.g., maintenance tasks, mandatory bookkeeping with no choices). Score 2 if most rules earn their place but a few are noise. Score 4 if every rule visibly contributes to the decision space — nothing can be cut without losing something.

### A8. Constitutive Rules Quality (0-5)

Examine the game's math — damage formulas, probability distributions, resource generation rates, cost curves. Check:
- Do the numbers produce the dynamics the game intends? (E.g., does a "risky" option actually have meaningful risk?)
- Are there degenerate edge cases? (E.g., damage formula that produces 0 or negative values, exponential growth that breaks after level 10.)
- Do probability distributions match player-facing language? (If something is described as "rare," is it actually rare?)

Score 0 if the math is broken (produces nonsensical values, overflows, or trivially exploitable). Score 2 if the math works in the common case but breaks at extremes. Score 4 if the numbers are well-calibrated and produce the intended dynamics across the full range of play.

### A9. Mechanic-Aesthetic Alignment (0-5)

Identify what experience the game appears to be going for (based on its theme, framing, and stated goals). Then check:
- Do the mechanics actually produce that experience during play?
- Or do they generate a different dynamic than what the game seems to promise?
- Example: A game themed around "desperate survival" where the player is never actually in danger has poor alignment.

Score 0 if the mechanics produce an experience completely at odds with the game's apparent intent. Score 2 if the alignment is partial — some mechanics fit, others don't. Score 4 if every mechanic reinforces the intended experience and playing feels like what the game promised.

### A10. Lusory Attitude Reward (0-5)

Check whether engaging with the game earnestly (playing in the spirit of its design) is rewarded:
- Is the player better off engaging with the mechanics as intended, or exploiting loopholes?
- Are there obvious degenerate strategies that reward ignoring the game's intended play patterns?
- Does the game incentivize the behavior it seems to want?

Score 0 if the optimal way to play contradicts the game's design intent (e.g., the best strategy in a combat game is to avoid all combat). Score 2 if earnest play is viable but exploits exist that are clearly superior. Score 4 if the most effective strategies are also the most engaging — the game rewards exactly the behavior it's designed around.