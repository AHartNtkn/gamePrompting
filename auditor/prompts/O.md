# Category O: Balance & Stability

You are evaluating whether the game is balanced and resistant to degenerate play. Focus on whether multiple strategies are viable, whether the game resists exploitation, and whether its difficulty curve produces sustained challenge rather than collapsing into triviality or impossibility.

## Criteria and Evaluation Instructions

### O1. Dominant Strategy Absence (0-5)

Identify every strategy available to the player, then compare them. Check:
- Is there one strategy that is clearly superior in all or nearly all situations? If the player discovers it, does every other option become pointless?
- Do different situations favor different approaches, or does one approach dominate across contexts?
- Simulate several different strategic approaches through the game — do they produce meaningfully different levels of success, or does one always win?

Score 0 if a single dominant strategy exists and renders all other options irrelevant — once discovered, the game is solved. Score 2 if most strategies are competitive but one is noticeably stronger than the rest in the majority of situations. Score 4 if no single strategy dominates — different contexts reward different approaches, and the player must adapt rather than memorize one winning formula.

### O2. Exploit Resistance (0-5)

Attempt to break the game by exploiting its rules. Check:
- Can you find loopholes that produce unintended advantages? (E.g., buying and selling the same item for profit, stacking effects in unintended ways, triggering actions with no intended cost.)
- Are there degenerate strategies that bypass the game's intended challenge entirely?
- Do the rules close off obvious exploits, or do they leave gaps that a systematic player would find quickly?

Score 0 if the game is trivially exploitable — a player looking for loopholes will find them within minutes and can bypass most challenge. Score 2 if the major exploits are closed but edge cases exist that a determined player could abuse. Score 4 if the rules are tight — systematic attempts to exploit produce no meaningful advantage, and the game's challenge must be met on its own terms.

### O3. AI Manipulation Resistance (0-5)

If the game has AI opponents or entities, attempt to manipulate their behavior. Check:
- Can you bait AI into predictable patterns that remove challenge? (E.g., leading enemies into positions where they can't fight back, exploiting pathfinding limitations.)
- Does the AI adapt to repeated player tactics, or does it fall for the same trick indefinitely?
- Can the player trivially avoid AI threats by exploiting behavioral rules? (E.g., standing just outside aggro range, kiting enemies that can't path around obstacles.)

Score 0 if AI behavior is trivially manipulable — the player can neutralize all AI threat through simple behavioral exploitation. Score 2 if AI resists basic manipulation but has exploitable patterns that a patient player will discover. Score 4 if AI behavior is robust — it cannot be reliably manipulated into non-threatening patterns, and the player must engage with it as genuine opposition.

### O4. Snowball Resistance (0-5)

Trace how early advantages compound over the course of a game. Check:
- Does gaining an early lead (more resources, better equipment, higher stats) make subsequent challenges disproportionately easier?
- Does the game have any mechanisms that moderate runaway advantages? (E.g., escalating costs, diminishing returns, increasing difficulty.)
- Can a player who gains an early advantage coast to victory without further meaningful decisions?

Score 0 if early advantages compound without limit — a player who gains an early lead faces trivially easy content for the remainder of the game and cannot lose. Score 2 if advantages compound but the game scales difficulty somewhat, keeping at least some pressure on a leading player. Score 4 if the game actively resists snowballing — advantages help but don't trivialize subsequent challenges, and the player must continue making good decisions throughout.

### O5. Death Spiral Resistance (0-5)

Trace how early disadvantages compound over the course of a game. Check:
- Does falling behind (losing resources, taking damage, failing an objective) make subsequent challenges disproportionately harder?
- Does the game create irrecoverable states where the player is effectively dead but hasn't technically lost?
- Are there recovery mechanisms that allow a disadvantaged player to claw back through skillful play?

Score 0 if early disadvantages compound into irrecoverable spirals — a player who falls behind faces increasingly impossible challenges and is effectively eliminated without a formal loss. Score 2 if disadvantages compound but recovery is possible through exceptional play or lucky breaks. Score 4 if the game provides meaningful recovery paths — falling behind makes things harder but not hopeless, and a skilled player can recover from setbacks.

### O6. Option Viability (0-5)

Catalog every option the game presents to the player — items, abilities, upgrades, paths, character builds, tactical choices. Check:
- Are all presented options worth considering, or are some clearly inferior?
- Are there trap options — choices that look viable but are never competitive?
- Is there a reason to choose each option in at least some situation?

Score 0 if many presented options are traps or dead weight — the player quickly learns which choices matter and ignores the rest, reducing the effective option space to a fraction of what's offered. Score 2 if most options are viable but a few are clearly inferior or redundant. Score 4 if every option the game presents is worth considering in the right context — there are no traps, no dead options, and the full option space is the real option space.

### O7. Grinding Non-Viability (0-5)

Check whether the player can bypass the game's designed challenges through repetition. Check:
- Can the player repeat trivial actions (farming weak enemies, collecting easy resources) to accumulate enough power to trivialize harder content?
- Does the game's structure make grinding an attractive alternative to engaging with its actual challenges?
- Are there mechanisms that prevent or disincentivize repetitive trivial play? (E.g., diminishing returns, level-scaled enemies, resource caps.)

Score 0 if grinding is the dominant strategy — the game's challenges are most easily overcome by repeating trivial actions until overpowered, and the game does nothing to prevent this. Score 2 if grinding is possible but slow enough that engaging with the designed challenges is comparably effective. Score 4 if grinding is not a viable strategy — the game's structure makes repetitive trivial play unrewarding, and the player must engage with the designed challenge curve.

### O8. Difficulty Scaling (0-5)

Track how challenge evolves as the player gains power. Check:
- Does obstacle or enemy difficulty increase in proportion to player power growth?
- Are there points where the player out-levels the content and challenge evaporates?
- Does the difficulty curve maintain pressure throughout, or does it plateau or collapse?
- Is difficulty scaling smooth, or are there sudden spikes that feel arbitrary?

Score 0 if difficulty fails to keep pace with player power — the game becomes trivially easy after the early game, with no mechanical pressure to sustain engagement. Score 2 if difficulty generally scales but has noticeable dead zones where the player is unchallenged, or spikes that feel unearned. Score 4 if difficulty scaling is well-calibrated — the game maintains consistent pressure throughout, with challenge growing in proportion to player capability and no dead zones or arbitrary spikes.

### O9. Two-Sided Coin (0-5)

Examine every powerful option available to the player — strong items, abilities, upgrades, strategies. Check:
- Does each powerful option carry a meaningful cost, tradeoff, or drawback?
- Or is power free — the player gains strength without giving up anything?
- Are drawbacks real (they actually constrain choices or create vulnerability) or cosmetic (nominal costs that don't matter in practice)?

Score 0 if power is free — the player accumulates advantages with no meaningful tradeoffs, and "stronger" is always strictly better with no downside. Score 2 if some powerful options have costs but others are pure upgrades with no drawback. Score 4 if every powerful option comes with a genuine tradeoff — gaining strength in one area requires sacrifice in another, and the player must weigh costs rather than just accumulate power.

### O10. Sequence Break Resistance (0-5)

Attempt to bypass the game's intended progression. Check:
- Can the player reach late-game content or power levels without completing the designed progression path?
- Are there unintended shortcuts — accessing areas, items, or abilities before the game intends?
- Does the game enforce its progression through mechanics (prerequisites, gating, scaling) or merely through convention (the player could skip ahead but chooses not to)?

Score 0 if the intended progression is trivially bypassable — the player can skip directly to late-game content or acquire endgame power without completing earlier challenges. Score 2 if the main progression is enforced but minor shortcuts exist that give the player unintended advantages. Score 4 if progression is mechanically robust — the player must engage with the designed sequence because each stage genuinely depends on completing the previous one, and shortcuts don't exist or don't confer meaningful advantage.

### O11. Asymmetric Balance (0-5) [CONDITIONAL: game has asymmetric options]

If the game offers different starting conditions, factions, characters, or classes, compare them. Check:
- Are asymmetric options balanced in overall power while being distinct in character?
- Or does one option dominate — is there a best faction, a best class, a best starting position?
- Do different options create genuinely different play experiences, or are they cosmetic variations on the same capabilities?

Score 0 if asymmetric options are wildly unbalanced — one choice is clearly superior and choosing anything else is a handicap. Score 2 if options are roughly balanced but one or two are noticeably stronger or weaker than the rest. Score 4 if all asymmetric options are competitive — each has distinct strengths and weaknesses, none dominates, and the choice between them is genuinely strategic rather than having an obvious correct answer.

### O12. Situational Tool Value (0-5)

Examine the game's tools, items, abilities, or tactical options across different contexts. Check:
- Does the optimal choice shift depending on the situation — enemy type, terrain, resource state, strategic phase?
- Or is there a fixed hierarchy of tools where the "best" tool is best in every situation?
- Must the player evaluate each situation to determine which tools to deploy, or can they use the same loadout for everything?

Score 0 if tool value is absolute — one tool or approach is best in every situation, and context never changes the optimal choice. Score 2 if some situational variation exists but a small set of tools covers most situations adequately. Score 4 if optimal tool choice varies significantly with context — the player must read each situation and select appropriate tools, and no single loadout handles all situations well.
