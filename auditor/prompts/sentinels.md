# Sentinel Checks: LLM Failure Mode Detection

You are checking a CLI game for common LLM-generated game failure modes and lazy design patterns. Unlike the graded category audits, sentinel checks are mostly **binary**: PASS or FAIL. A few are CONDITIONAL (the check doesn't apply if the game lacks the relevant feature — mark these N/A).

Your job is to be a skeptic. Assume the game has these problems until you see evidence it doesn't. For each sentinel, look at the actual code and mentally simulate gameplay — many failures are invisible in a code skim but obvious during play.

## Process

1. Read the source code thoroughly.
2. For each sentinel below, determine: PASS, FAIL, or N/A.
3. For every FAIL, cite the specific code location or mechanic that triggers it.
4. For every PASS, state what evidence convinced you (not just "I didn't see the problem").

## Sentinel Checks

### I. Hollow Core

**S1. Menu Screen Game**
Check: Compare the amount of code dedicated to menus, title screens, settings, and setup versus the core gameplay loop. If the gameplay loop could be described in under 20 lines of logic while menus span hundreds of lines, FAIL.

**S2. Decorative Systems**
Check: For every stat, gauge, or named system displayed to the player, trace whether it affects any gameplay outcome (combat results, available options, win/loss conditions). If any displayed system has zero mechanical effect, FAIL. Cite which system is decorative.

**S3. Orphaned References**
Check: Search for entity names (locations, NPCs, items, features) mentioned in player-facing text that have no corresponding game logic or data. If any reference points to nothing, FAIL. Cite the orphaned reference.

**S4. Trivial Combat / Zero-Risk Encounters** `[CONDITIONAL: game has combat]`
Check: Mentally simulate 10 combat encounters using only the basic attack option. If the player never drops below 50% health and wins every fight, FAIL.

**S5. No Failure State**
Check: Can the player lose, die, go bankrupt, or otherwise fail? What does failure cost (resources, progress, the run)? If there is no meaningful failure consequence, FAIL.

### II. Isolated Systems

**S6. Isolated Systems**
Check: List every game system. For each pair, identify at least one interaction (system A's output affects system B's state). If most system pairs have zero interactions, FAIL. Cite which systems are isolated.

**S7. Feature Checklist Design**
Check: Count distinct systems. For each, count the number of meaningful decisions it offers the player. If there are more than 4 systems and none offers more than 3 meaningful decisions, FAIL.

**S8. Cargo-Cult Mechanics**
Check: For each non-core system (durability, hunger, weather, morale, etc.), ask: "What decision does this force the player to make?" If the answer is "none" or "the single obvious one" (e.g., "eat when hungry"), FAIL for that mechanic. If more than one mechanic is cargo-cult, FAIL overall.

### III. Paint-By-Numbers Combat `[CONDITIONAL: game has combat]`

**S9. Attack/Defend/Flee Trinity**
Check: Count combat options. If they are exactly 3, are static across all encounters, and one dominates in most situations, FAIL.

**S10. Rock-Paper-Scissors As Entire System**
Check: If there exists a 1:1 mapping from enemy type to optimal player choice that never changes (know type → know answer), FAIL.

**S11. HP Sponge Difficulty**
Check: Compare enemy types at different game stages. If later enemies differ only in stat values (more HP, more damage) with no new abilities, behaviors, or tactical requirements, FAIL.

**S12. Useless Defend Command**
Check: Is there any encounter where defending is the optimal choice for at least one turn? Simulate it. If "always attack" is always optimal, FAIL.

**S13. Damage Type Inflation**
Check: Count distinct damage types. For each, check whether it does anything other than multiply damage via a resistance table. If all types are just "deal X * multiplier," FAIL.

**S14. Subtraction Damage Formula**
Check: Find the damage formula. If it uses raw subtraction (attack - defense = damage), test extreme values. If defense can reduce damage to 0 or below with no floor, or if low defense values have no effect, FAIL.

### IV. Paint-By-Numbers Economy `[CONDITIONAL: game has economy/resources]`

**S15. Generic Three Resources**
Check: Count resources. If exactly 3 and all work identically (gained from sources, spent in recipes, no unique mechanics), FAIL.

**S16. Linear Currency Treadmill**
Check: Is there only one currency? Does the player ever face a meaningful choice between two things they can't both afford? If single currency with no spending dilemmas, FAIL.

**S17. Infinite Accumulation**
Check: Does any resource have a cap, decay rate, storage limit, or maintenance cost? If no resource has any pressure to spend, FAIL.

**S18. Economy Doesn't Flow**
Check: Track resources earned vs. spent over a simulated 20-turn session. If the player accumulates a growing surplus with nothing meaningful to spend it on, or if essential resources are unobtainable, FAIL.

### V. Paint-By-Numbers Progression `[CONDITIONAL: game has progression/leveling system]`

**S19. Linear Skill "Tree"**
Check: If there's a skill/upgrade tree, check for mutually exclusive branches with qualitatively different effects. If no real branching exists, FAIL.

**S20. Percentage Stat Bonuses As "Skills"**
Check: For each upgrade, does it change what the player DOES (new ability, modified mechanic) or only a number (+5% damage)? If >80% are pure stat modifiers, FAIL.

**S21. Level-Gating**
Check: Are there gates that check only a level/XP number rather than a skill, item, or achievement? If progression is blocked purely by "grind more XP," FAIL.

**S22. Meaningless Stat Inflation**
Check: Compare the ratio of player attack to enemy HP at early vs. late game. If the ratio is identical (numbers grew proportionally), FAIL.

**S23. Equipment Treadmill**
Check: List equipment in acquisition order. If each item is strictly better in all dimensions than the previous (no sidegrades, no trade-offs), FAIL.

**S24. Building Upgrade Tiers** `[CONDITIONAL: game has building/upgrade systems]`
Check: Do building upgrades ever change WHAT the building does (qualitative) or only HOW MUCH (quantitative, e.g., +20% output)? If purely quantitative, FAIL.

### VI. Information & Interface

**S25. Wall of Text**
Check: Find the longest single output the game produces before requesting player input. Count lines. If any output exceeds 25 lines with no formatting structure (headers, breaks, bullet points), FAIL.

**S26. Stats Dump Every Screen**
Check: On a typical gameplay screen, count displayed stats. Count how many are relevant to the player's current decision. If >50% are irrelevant to what the player is doing right now, FAIL.

**S27. Numbered Menu For Everything**
Check: Count distinct interaction types. If >80% of player interactions are selecting from static numbered lists, FAIL. Also: do the menus change based on game state, or are they always identical?

**S28. Press-Any-Key Spam**
Check: Count "press enter to continue" / "press any key" prompts in a typical 5-minute play session. If >3 per minute with no decision between them, FAIL.

**S29. Invisible Feedback**
Check: Perform each available player action and check the output. Does the game tell the player what changed and why? If any action produces no feedback or only "OK," FAIL.

**S30. Missing Input Validation**
Check: Try inputs with wrong case, abbreviations, extra spaces, typos, and empty input. If the game crashes, produces cryptic errors, or silently does nothing for reasonable input variations, FAIL.

**S31. Inconsistent Command Vocabulary**
Check: Try the same action verb in multiple contexts. If "use" works in one place and requires "apply" or "activate" in another with no in-game reason, FAIL.

### VII. World-Building Autopilot

**S32. Generic Fantasy Default** `[CONDITIONAL: game has fantasy setting]`
Check: List the setting's distinguishing features. Could you swap this setting with any other generic fantasy game without anyone noticing? If yes, FAIL.

**S33. The Four Factions** `[CONDITIONAL: game has factions]`
Check: Count factions. If each has exactly one defining trait with no overlap, internal tension, or complexity, FAIL.

**S34. Evil-For-Evil's-Sake Antagonist** `[CONDITIONAL: game has characterized antagonist]`
Check: Can the antagonist's motivation be stated without the words "evil," "destroy," or "power"? If not, FAIL.

**S35. Lore Dump Delivery** `[CONDITIONAL: game has lore/world-building]`
Check: What percentage of world-building is delivered through NPC monologues or found text vs. through environment, mechanics, or character behavior? If >80% is exposition text, FAIL.

**S36. Amnesia Protagonist** `[CONDITIONAL: game has narrative-framed protagonist]`
Check: Does the game open with "you wake up with no memory" or equivalent? Does the first interaction involve a meaningful game decision? If amnesia framing + no early decision, FAIL.

**S37. "You Are In A Room" Descriptions** `[CONDITIONAL: game has spatial/environmental descriptions]`
Check: Read location descriptions. Do they contain sensory language (sound, smell, temperature, light, texture)? Or are they exclusively inventories of objects and exits? If no sensory content, FAIL.

**S38. Generic Naming**
Check: List all named entities (locations, NPCs, items). If >50% could appear in any generic game without modification ("The Old Tavern," "Mysterious Stranger," "Ancient Sword"), FAIL.

**S39. Calm Village Opening** `[CONDITIONAL: game has spatial narrative opening]`
Check: Does the starting area contain any conflict, threat, decision, or mystery? If it's purely functional (shop + quest giver + exit), FAIL.

### VIII. Structural Autopilot

**S40. Hub-and-Spoke, No Cross-Connections** `[CONDITIONAL: game has multi-area spatial topology]`
Check: Draw the connectivity graph. If removing the hub disconnects all areas, and no event in area A affects area B, FAIL.

**S41. Identical Loop Every Cycle**
Check: Describe the structure of 3 non-adjacent game cycles (turns, days, missions). If structurally identical (same phases, same order, same emphasis), FAIL.

**S42. Template Clone**
Check: Can you identify a specific existing game this is structurally identical to? If there's a 1:1 mapping with no innovations, FAIL.

**S43. Symmetry As Default**
Check: If the game has factions/classes/options, compare their mechanical structure. If identical except for labels/themes, FAIL.

**S44. Linear One-Path Design**
Check: Map the spatial or decision structure. If there's only one valid path through the game with no branches, loops, or alternatives, FAIL.

### IX. Untested Gameplay

**S45. NPC/Entity Blocking** `[CONDITIONAL: game has spatial navigation with entity positions]`
Check: Simulate navigating the full map. Can any entity position create an impassable chokepoint that prevents reaching objectives? If yes, FAIL.

**S46. World Amnesia** `[CONDITIONAL: game has revisitable locations]`
Check: Mentally simulate: modify a location (kill enemy, take item), leave, return. Does the modification persist? If the location resets, FAIL.

**S47. Unwinnable/Softlock States**
Check: Test edge cases — zero resources, dead-end nodes, exhaustible resource gates. Can the player reach a state where progress is impossible but the game doesn't recognize it? If yes, FAIL.

**S48. Boundary Errors**
Check: Test boundary actions — move off map edge, use last item, fill inventory, reach exactly 0 HP. Does the game handle each correctly? If any produces a crash or nonsensical state, FAIL.

**S49. State Tracking Bugs**
Check: Trace key state variables (inventory, equipment, quest flags, counters) across multiple actions. Is any state silently lost or reverted? If yes, FAIL.

**S50. Snowball Without Correction**
Check: Simulate a player who wins early vs. one who loses early. Does winning compound without limit? Is there any recovery mechanism for falling behind? If the gap widens without bound, FAIL.

**S51. Exponential Scaling Collapse**
Check: Calculate stat/cost values at levels 1, 10, 20, 50. If they span more than 3 orders of magnitude, FAIL.

**S52. Procedural Sameness** `[CONDITIONAL: game uses procedural/random generation]`
Check: Mentally generate 10 instances of any procedurally generated content. If >80% share elements or structure, FAIL.

### X. Miscellaneous

**S53. Fetch Quest Padding** `[CONDITIONAL: game has quest/objective structures]`
Check: List all objectives. If >50% follow the same verb structure (go-get-return or equivalent), FAIL.

**S54. Everything Explained, Nothing Discovered**
Check: Are there any mechanics or interactions the player can discover through experimentation that aren't explicitly documented? If every interaction is pre-described, FAIL.

**S55. Repetitive Name Generation** `[CONDITIONAL: game procedurally generates named entities]`
Check: Generate 10 named entities. If there are name collisions or near-duplicates, FAIL.

**S56. QTE/Reflex In Turn-Based Games**
Check: Does any mechanic change the fundamental timing contract (turn-based game suddenly requiring speed)? If yes, FAIL.

**S57. Random Events Without Decisions**
Check: Examine random events. Do >80% just modify stats with no player decision or response option? If yes, FAIL.

**S58. Happiness As A Single Number** `[CONDITIONAL: game has morale/happiness mechanic]`
Check: Is morale a single 0-100 scalar with no interacting dimensions? If yes, FAIL.

**S60. Scripted Phase Triggers**
Check: Search for conditionals keyed on turn number, elapsed time, cumulative score, or fixed thresholds that change game rules, unlock content, or alter difficulty (e.g., `if turn >= 10`, `if score >= 100`). If the game's phase structure would disappear entirely if these conditionals were removed — because the underlying systems produce no natural differentiation on their own — FAIL.

## Output Format

Output your results in exactly this format:

```
SENTINEL RESULTS
S1: PASS|FAIL|N/A — [brief evidence]
S2: PASS|FAIL|N/A — [brief evidence]
...
PASSED: [count]
FAILED: [count]
NA: [count]
FAILED_IDS: [comma-separated list of failed sentinel IDs, or "none"]
```

The PASSED, FAILED, NA, and FAILED_IDS lines are used for automated aggregation.