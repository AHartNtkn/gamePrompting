# Sentinel Criteria Catalog

Sentinel criteria detect common failure modes in LLM-generated games and paint-by-numbers design patterns. Unlike the main criteria catalog (which evaluates design quality on a spectrum), sentinel criteria are mostly binary flags: **present or absent**. Their purpose is to catch specific, concrete failure modes that correlate strongly with bad outcomes.

These criteria are not universal game design wisdom. Some sacrifice a sliver of the design space to head off statistically common lazy patterns. A game that violates one of these *could* be doing something clever — but in the context of LLM-generated games, it almost certainly isn't.

Each sentinel has:
- **Pattern**: What to look for (concrete, checkable)
- **Why it's a flag**: What it correlates with
- **Detection**: How an auditor can check for it

---

## I. Hollow Core (The Game Looks Like A Game But Isn't One)

These detect games that have the structure/chrome of a game but lack a functional gameplay loop.

**S1. Menu Screen Game**
Pattern: More code/effort is dedicated to title screens, settings, help text, and character creation than to the core gameplay loop.
Why: LLM training data is dominated by game scaffolding and boilerplate. The model generates what it's seen most: setup code. The actual gameplay is an afterthought.
Detection: Compare lines of code for menus/setup vs. the core loop. If the core loop could be described in 20 lines, the game is hollow.

**S2. Decorative Systems**
Pattern: Stats, systems, or mechanics are displayed but have no mechanical effect on gameplay outcomes. E.g., a "morale" stat that appears in the UI but never influences anything.
Why: LLMs generate system descriptions and UI displays without connecting them to game logic.
Detection: For each displayed stat or named system, trace whether it affects any gameplay outcome. If removing it changes nothing, it's decorative.

**S3. Orphaned References**
Pattern: The game mentions locations, NPCs, items, or features that don't exist in the actual game state. Code paths that are never triggered.
Why: LLMs generate content in segments that reference planned features or common patterns that were never implemented.
Detection: Search for entity names in text output that have no corresponding game logic or data.

**S4. Trivial Combat / Zero-Risk Encounters** `[CONDITIONAL: game has combat]`
Pattern: Every fight is winnable by spamming the basic attack. No possibility of losing, no resource cost, no tactical decision.
Why: LLMs set combat parameters conservatively to ensure the game is "playable" without testing.
Detection: Play 10 encounters using only basic attack. If the player never drops below 50% HP, combat has no teeth.

**S5. No Failure State**
Pattern: The player cannot lose, or losing has no consequence. There are no stakes.
Why: LLMs optimize for "the game works" rather than "the game creates tension." Failure states require handling edge cases.
Detection: Can the player fail? What does failure cost? If the answer is "nothing," flag it.

---

## II. Systems That Don't Talk (Isolated Mechanics)

These detect games where systems exist side-by-side but never interact.

**S6. Isolated Systems**
Pattern: The game has multiple systems (combat, economy, crafting, exploration) but they don't influence each other. Crafting doesn't affect combat. Economy doesn't affect crafting. Each is a self-contained island.
Why: LLMs generate each system from its own template in training data. A "crafting system" is generated from crafting patterns; a "combat system" from combat patterns. They're never integrated.
Detection: For each pair of systems, identify at least one interaction. If most pairs have zero interactions, the game is scattered.

**S7. Feature Checklist Design**
Pattern: The game has many systems (crafting AND combat AND base building AND dialogue AND skill trees) but none has depth. Each has the minimum viable implementation.
Why: When prompted to make a "deep" game, LLMs add breadth (more systems) rather than depth (more decisions per system).
Detection: Count systems. Rate each by number of meaningful decisions it offers. If >4 systems and none offers >3 meaningful decisions, flag it.

**S8. Cargo-Cult Mechanics**
Pattern: The game has durability, hunger, weather, etc. because "good games have those," but none creates meaningful decisions. Durability just means visiting a repair NPC.
Why: LLMs include mechanics from well-regarded games without understanding why those mechanics work in those specific contexts.
Detection: For each system, ask "what decision does this force?" If the answer is "none" or "the only obvious one," it's cargo cult.

---

## III. Paint-By-Numbers Combat `[CONDITIONAL: game has combat]`

These detect combat systems that follow the most common template without any design reasoning.

**S9. Attack/Defend/Flee Trinity**
Pattern: Combat presents exactly 3 static options (attack, defend, flee) with no variation per encounter, no context-sensitive options, and no additional mechanics.
Why: This is the most common combat template in tutorials, examples, and training data. It's the default an LLM reaches for.
Detection: Count combat options. If they are static across all encounters and number exactly 3, flag it.

**S10. Rock-Paper-Scissors As The Entire System**
Pattern: Three types form a cycle (fire/ice/lightning, sword/axe/lance). Knowing the enemy type is sufficient to determine the optimal action.
Why: Element triangles are the most common "depth" addition to basic combat in training data.
Detection: If a 1:1 mapping from enemy type to optimal player choice exists and never changes, the system is degenerate.

**S11. HP Sponge Difficulty**
Pattern: Later enemies are identical to earlier ones with multiplied HP/damage. No new behaviors, abilities, or tactical requirements.
Why: Scaling numbers is trivial; designing new enemy behaviors requires new mechanics.
Detection: Compare enemy types at different stages. If they differ only in stats and not in abilities or behaviors, flag it.

**S12. Useless Defend Command**
Pattern: A "Defend" option exists but is never optimal because attacking always produces better results.
Why: RPGs "should" have a defend command, so LLMs include one, but don't balance it to be useful.
Detection: Is there any encounter where defending is the best choice? If not, it's dead weight.

**S13. Damage Type Inflation**
Pattern: 5+ damage types exist (fire, ice, lightning, etc.) but they all do the same thing — modify a damage number via a resistance table. No qualitative differences.
Why: LLMs generate element systems from the common template without adding functional differentiation.
Detection: Does each damage type do anything other than multiply damage? If all are just lookup modifiers, flag it.

**S14. Subtraction Damage Formula**
Pattern: Combat uses `attack - defense = damage`, causing fights where defense is either meaningless (low values) or makes the player deal zero damage (high values).
Why: This is the simplest damage formula in training data. It breaks at extreme values but LLMs don't test extremes.
Detection: Test extreme stat values. Check for scenarios where damage clamps to zero or defense has no effect.

---

## IV. Paint-By-Numbers Economy `[CONDITIONAL: game has economy/resources]`

These detect resource/economy systems that follow the most common template.

**S15. Generic Three Resources**
Pattern: Exactly three resources (gold/wood/stone or equivalent). All work identically — gained from designated sources, spent in recipes.
Why: This is the Age of Empires / Settlers template. LLMs reach for it by default.
Detection: Count resources. Check if any resource has a unique mechanic (decay, sharing, spatial constraints, conversion). If all work identically, flag it.

**S16. Linear Currency Treadmill**
Pattern: One dominant currency. Everything costs it. You earn it from everything. The player never faces a meaningful spending dilemma.
Why: Single-currency systems are the simplest economy to implement.
Detection: Is there only one currency? Does the player ever face a choice between two things they can't both afford?

**S17. Infinite Accumulation**
Pattern: Resources accumulate without limit. No decay, maintenance cost, storage limit, or pressure to spend. Optimal play is to hoard.
Why: LLMs implement resource acquisition without implementing sinks, caps, or diminishing returns.
Detection: Does any resource have a cap, decay rate, or maintenance cost? If not, flag it.

**S18. Economy Doesn't Flow**
Pattern: Currency accumulates with nothing to spend it on, or essential resources are impossible to obtain. Shops sell items outclassed by free loot.
Why: LLMs generate sources and sinks independently without modeling flow equilibrium.
Detection: Track resources earned vs. spent over a simulated session. Check for runaway accumulation or starvation.

---

## V. Paint-By-Numbers Progression `[CONDITIONAL: game has progression/leveling system]`

These detect progression systems that provide numbers-go-up without meaningful change.

**S19. Linear Skill "Tree"**
Pattern: A skill tree is presented but has no meaningful branches — only one path, or one obviously optimal path, or all paths converge.
Why: Tree visuals promise agency but delivering actual branching requires designing multiple viable builds.
Detection: Check for mutually exclusive branches with qualitatively different effects. If none exist, it's a line.

**S20. Percentage Stat Bonuses As "Skills"**
Pattern: >80% of upgrades are "+5% damage," "+10% health" — pure stat modifiers that don't change what the player does.
Why: Stat bonuses are the easiest upgrades to generate. New abilities require new mechanics.
Detection: For each upgrade, does it change what the player DOES or only how much a number is? If >80% are stat modifiers, flag it.

**S21. Level-Gating**
Pattern: Content locked behind arbitrary level requirements. The player has the skill to handle it, but "You must be level 15."
Why: Level gates are the simplest progression lock. They don't require designing skill-based challenges.
Detection: Are there gates that check only a level/XP number? Flag any gate whose only requirement is "grind more."

**S22. Meaningless Stat Inflation**
Pattern: Player stats go from 10 to 1000, but enemies scale proportionally. The ratio never changes; numbers are bigger but the game is the same.
Why: LLMs implement scaling systems without checking whether the scaling changes anything.
Detection: Compare player-attack-to-enemy-HP ratio at early vs. late game. If identical, inflation is meaningless.

**S23. Equipment Treadmill**
Pattern: Progression is replacing equipment with numerically superior equipment. No trade-offs, synergies, or situational advantages.
Why: LLMs generate equipment as stat bundles ordered by level.
Detection: Is each subsequent item strictly better in all dimensions? If so, it's a treadmill.

**S24. Building Upgrade Tiers** `[CONDITIONAL: game has building/upgrade systems]`
Pattern: Every building has Level 1-5. Each level costs more and produces more. The upgrade is always worth it; the only constraint is cost.
Why: Linear building upgrades are the simplest structure-progression template.
Detection: Do building upgrades ever change WHAT the building does (qualitative) or only HOW MUCH (quantitative)?

---

## VI. Information & Interface Failure Modes

These detect common output/display problems in LLM-generated games.

**S25. Wall of Text**
Pattern: Every game state display produces paragraphs of prose. The player is overwhelmed every turn. Critical information is buried in description.
Why: LLMs are trained to be verbose and treat completeness as quality.
Detection: Count words per turn output. If any single output exceeds 20 lines without structure (headers, breaks, formatting), flag it.

**S26. Stats Dump Every Screen**
Pattern: Every screen shows all stats (HP, MP, Gold, STR, DEX, INT, Level, XP) whether or not they're relevant to the current context.
Why: Displaying everything is simpler than implementing contextual information display.
Detection: Check what percentage of displayed stats are relevant to the current decision. If >50% are irrelevant, flag it.

**S27. Numbered Menu For Everything**
Pattern: >80% of player interactions are selecting from numbered lists. The entire game is navigating menus.
Why: Numbered menus are the easiest input handling to implement. LLMs default to them.
Detection: Count distinct interaction types. If >80% are numbered-menu selections, flag it. Also check: do menus change based on context?

**S28. Press-Any-Key Spam**
Pattern: "Press enter to continue" between every screen with no intervening decision.
Why: LLMs insert pauses at every output boundary without considering whether the pause serves a purpose.
Detection: Count press-to-continue prompts per minute. If >3 per minute with no intervening decision, flag it.

**S29. Invisible Feedback**
Pattern: The player acts but gets no indication of what happened. "You attack" with no damage number, or stat changes that occur silently.
Why: LLMs generate game logic and display logic separately and may not connect them.
Detection: Perform every available action and check whether each produces output explaining what changed and why.

**S30. Missing Input Validation**
Pattern: The game accepts "attack" but not "Attack" or "ATTACK". Unrecognized commands produce cryptic errors or crashes.
Why: LLMs generate the happy path without considering input variance.
Detection: Input misspellings, wrong case, abbreviations, extra spaces, empty strings. Check graceful handling.

**S31. Inconsistent Command Vocabulary**
Pattern: "use key" works in one room, "unlock door with key" is required in another, "open" works in a third but "unlock" doesn't.
Why: LLMs generate input handling per-scene rather than from a centralized parser.
Detection: Try the same verb in multiple contexts. If it works in some and fails silently in others, flag it.

---

## VII. World-Building Autopilot

These detect settings and narratives produced by autocomplete rather than design reasoning.

**S32. Generic Fantasy Default** `[CONDITIONAL: game has fantasy setting]`
Pattern: Kings, castles, swords, magic, elves or elf-equivalents, evil empire. Nothing distinguishes this setting from the default fantasy template.
Why: Generic fantasy is the highest-probability completion for "game setting."
Detection: List distinguishing features. Could you swap this setting with another generic fantasy game without anyone noticing?

**S33. The Four Factions** `[CONDITIONAL: game has factions]`
Pattern: Exactly 4 factions, each defined by a single trait (warrior/magic/nature/technology). They map to a clean taxonomy with no overlap.
Why: Four is the most common faction count in training data. One-trait-per-faction is the simplest differentiation.
Detection: Count factions. Check if each has exactly one defining trait with no overlap or internal tension.

**S34. Evil-For-Evil's-Sake Antagonist** `[CONDITIONAL: game has characterized antagonist]`
Pattern: The villain wants to destroy/conquer because they're evil. No comprehensible motivation.
Why: The "dark lord" is the highest-probability antagonist pattern.
Detection: Can the antagonist's motivation be stated without the words "evil," "destroy," or "power"?

**S35. Lore Dump Delivery** `[CONDITIONAL: game has lore/world-building]`
Pattern: >80% of world-building is delivered through NPC monologues or found text documents rather than through gameplay, environment, or behavior.
Why: Text generation is what LLMs do best. Delivering lore through text is the path of least resistance.
Detection: What percentage of world-building is exposition vs. environmental/mechanical/behavioral?

**S36. Amnesia Protagonist** `[CONDITIONAL: game has narrative-framed protagonist]`
Pattern: The game starts with "You wake up with no memory..." or multiple paragraphs of lore before the first decision.
Why: Amnesia is the most common narrative framing because it conveniently explains why the player knows nothing.
Detection: Check the first 3 interactions. If none involve a meaningful game decision, the opening is exposition-heavy.

**S37. "You Are In A Room" Descriptions** `[CONDITIONAL: game has spatial/environmental descriptions]`
Pattern: Location descriptions read like database entries: "You are in a forest. There is a path to the north. There is a tree." No atmosphere, no sensory detail.
Why: LLMs thinking in data structures (room has: exits, objects) rather than experiences.
Detection: Check descriptions for sensory language (sound, smell, temperature, light). If descriptions are exclusively inventories, flag it.

**S38. Generic Naming**
Pattern: Every entity uses the most generic name from the fantasy template — "The Old Tavern", "Mysterious Stranger", "Ancient Sword."
Why: These are the highest-probability name completions.
Detection: List all named entities. If >50% could appear in any generic fantasy game without modification, flag it.

**S39. Calm Village Opening** `[CONDITIONAL: game has spatial narrative opening]`
Pattern: Game starts in a peaceful village with a shop, quest-giver, and exit to "the real game." Nothing interesting happens there.
Why: This is the most common game opening template.
Detection: Does the starting area contain any conflict, threat, decision, or mystery? If purely functional, flag it.

---

## VIII. Structural Autopilot

These detect game structures that follow templates rather than design reasoning.

**S40. Hub-and-Spoke, No Cross-Connections** `[CONDITIONAL: game has multi-area spatial topology]`
Pattern: A central hub connects to N independent areas. No area connects to any other. Events in one area never affect another.
Why: Hub-and-spoke is the simplest world topology to generate.
Detection: If removing the hub disconnects all areas, and no event in area A affects area B, flag it.

**S41. Identical Loop Every Cycle**
Pattern: Every level/day/mission follows the exact same structure (gather → build → fight → reward) with no variation.
Why: LLMs generate one loop and replicate it; varying the loop requires modeling a temporal arc.
Detection: Describe the structure of 5 non-adjacent cycles. If structurally identical, flag it.

**S42. Template Clone**
Pattern: The game's structure is recognizably identical to a well-known game with no meaningful deviation.
Why: LLMs trained on descriptions of popular games reproduce their structure rather than designing from principles.
Detection: Can you identify a 1:1 structural mapping to a specific existing game? If yes and there are no innovations, flag it.

**S43. Symmetry As Default**
Pattern: All factions/classes/options are mechanically identical with different names/themes.
Why: Symmetric options are trivially easy to generate; asymmetric ones require balancing.
Detection: Compare mechanical structure of different options. If identical except for labels, flag it.

**S44. Linear One-Path Design**
Pattern: The map is a corridor with no branches, loops, or alternative paths.
Why: Linear paths are the simplest structure and don't require handling nonlinear state.
Detection: Map the spatial structure. If there's only one valid path through each area, flag it.

---

## IX. Untested Gameplay (Looks Right, Plays Wrong)

These are detectable only by actually playing or simulating play.

**S45. NPC/Entity Blocking** `[CONDITIONAL: game has spatial navigation with entity positions]`
Pattern: NPCs or entities occupy spaces that prevent the player from moving, navigating, or reaching objectives.
Why: LLMs place entities without modeling movement corridors or considering blocking.
Detection: Attempt to navigate the full map. Check if any entity positions create impassable chokepoints.

**S46. World Amnesia** `[CONDITIONAL: game has revisitable locations]`
Pattern: Leaving a room and returning resets it — defeated enemies respawn, items reappear, conversations reset.
Why: LLMs render each room from its definition rather than from mutable state.
Detection: Modify a location (kill enemy, take item), leave, return. Check persistence.

**S47. Unwinnable/Softlock States**
Pattern: The player can reach a state where progress is impossible but the game doesn't recognize it. No game over, no recovery — a silent dead end.
Why: LLMs generate forward paths without modeling the state space for reachability.
Detection: Test edge cases: zero resources, dead-end nodes, exhaustible resource gates.

**S48. Boundary Errors**
Pattern: Moving off map edges, using the last item, filling inventory, or reaching 0 HP causes crashes or nonsensical state.
Why: LLMs generate code for the typical case without testing edge values.
Detection: Attempt boundary actions at every limit.

**S49. State Tracking Bugs**
Pattern: Equipped items disappear, quest flags reset, counters fail to increment mid-session.
Why: LLMs generate state-modifying code per-function without ensuring global state consistency.
Detection: Track key state variables across multiple actions. Check for silent reverts.

**S50. Snowball Without Correction**
Pattern: Winning the first few encounters creates compounding advantages with no recovery mechanism for falling behind.
Why: LLMs model rewards for success but not stabilizing forces.
Detection: Simulate a player who wins early vs. one who loses early. Check if the gap widens without bound.

**S51. Exponential Scaling Collapse**
Pattern: Exponential growth in stats/costs makes early-game items worthless, breaks UI, and creates wild difficulty swings between levels.
Why: LLMs use exponential formulas from tutorials without calculating values at higher levels.
Detection: Calculate stat values at levels 1, 10, 20, 50. If they span >3 orders of magnitude, flag it.

**S52. Procedural Sameness** `[CONDITIONAL: game uses procedural/random generation]`
Pattern: "Randomly generated" content all feels identical because the generation pool is tiny and there's no structural variation.
Why: LLMs generate one generation template but don't populate enough variety or structural variation rules.
Detection: Generate 10 instances. If they share >80% of elements or structure, flag it.

---

## X. Miscellaneous Red Flags

**S53. Fetch Quest Padding** `[CONDITIONAL: game has quest/objective structures]`
Pattern: >50% of objectives follow the same structure (go to X, get Y, return to Z) with no strategic decision-making.
Why: Fetch quests are the most templated quest structure in training data.
Detection: List all objectives. If >50% share the same verb structure, flag it.

**S54. Everything Explained, Nothing Discovered**
Pattern: Every mechanic, interaction, and secret is explicitly described. There are no hidden interactions or "what if I try this?" moments.
Why: LLMs err on the side of explaining everything rather than leaving things for the player to discover.
Detection: Are there any mechanics the player can discover on their own? If everything is pre-described, flag it.

**S55. Repetitive Name Generation** `[CONDITIONAL: game procedurally generates named entities]`
Pattern: Multiple NPCs or locations get the same or nearly identical names.
Why: Without explicit randomization, LLMs converge on the same high-probability completions.
Detection: Generate 10 entities and check for name collisions or near-duplicates.

**S56. QTE/Reflex In Turn-Based Games**
Pattern: A turn-based game suddenly requires timed input or real-time reflexes.
Why: LLMs mix mechanics from different genres without recognizing incompatible timing contracts.
Detection: Check if any mechanic changes the fundamental timing contract.

**S57. Random Events Without Decisions**
Pattern: Random events are pure stat changes ("A flood! -20 food") with no player response or mitigation option.
Why: Stat-modification events are trivial to generate. Events with choices require designing multiple outcomes.
Detection: Do random events offer the player a decision? If >80% are pure stat modifications, flag it.

**S59. Prompt Echo As Flavor Text**
Pattern: The game's title screen, descriptions, or UI text repeats phrases or requirements from the generation prompt as if they were the game's own marketing copy. E.g., a prompt saying "must simulate body parts" produces a title screen reading "Body Part Damage" as a feature bullet point.
Why: LLMs treat the prompt as content to parrot rather than instructions to follow. Real games don't advertise their design requirements on the title screen — Mario doesn't say "Platformer · Mushroom Power-Ups · Save Princess."
Detection: Compare the game's player-facing text (title screen, descriptions, help text) against the generation prompt. If phrases from the prompt appear verbatim or near-verbatim as in-game text, FAIL.

**S58. Happiness As A Single Number** `[CONDITIONAL: game has morale/happiness mechanic]`
Pattern: Morale/happiness is a single 0-100 scalar that goes up or down from events, with no multi-dimensional structure.
Why: Single scalars are the simplest model. Multi-dimensional satisfaction requires designing tensions.
Detection: Is morale a single number with no interacting dimensions? Flag it.

**S60. Scripted Phase Triggers**
Pattern: The game uses hardcoded turn counts, timers, or threshold checks to artificially impose phase transitions, difficulty changes, or content unlocks (e.g., `if turn >= 10: unlock_tier_2()`, `if score >= 100: spawn_boss()`). Macro-level structure is bolted on rather than emerging from system interactions.
Why: LLMs default to scripted triggers because they're the simplest way to create the appearance of phases. In a well-designed simulation, phases emerge because systems naturally reach different equilibria — resource depletion shifts priorities, capability accumulation opens strategies, environmental pressure changes the viable action space. Scripted triggers bypass the simulation and undermine the coherence that makes simulations compelling.
Detection: Search for conditionals keyed on turn number, elapsed time, cumulative score, or fixed thresholds that change game rules, unlock content, or alter difficulty. If the game's phase structure would disappear entirely if these conditionals were removed (because the underlying systems produce no natural differentiation), FAIL.

**S61. Described-But-Not-Interactable Nouns**
Pattern: Location or scene descriptions mention specific objects, features, or entities that the player cannot examine, interact with, or reference in commands.
Why: LLMs generate atmospheric descriptions by listing objects, then implement interaction handlers separately. The description and the interactable object model diverge, creating false affordances.
Detection: Pick 5 nouns mentioned in environmental descriptions. Attempt to examine or interact with each. If >50% produce "I don't understand" or equivalent, FAIL.

**S62. Emotional Narration**
Pattern: The game tells the player what their character feels rather than describing what exists. "You feel a chill of terror," "An overwhelming sense of dread washes over you."
Why: LLMs default to emotion-labeling because training data is full of narrative prose that names emotions. Good text game design describes the world and lets the player supply the emotion.
Detection: Search game output for phrases matching "you feel [emotion]," "a sense of [emotion]," "you are [emotion-adjective]." If >3 instances occur in a normal play session, FAIL.

**S63. Uniform Output Length**
Pattern: Every game output is approximately the same length regardless of what happened. Walking to an adjacent room produces the same amount of text as discovering a critical secret.
Why: LLMs generate outputs of similar length because they have no internal model of event significance.
Detection: Compare output length for 5 routine actions vs. 5 significant events. If the ratio is <1.5x, FAIL.

**S64. Wiki-Required Mechanics**
Pattern: The game has mechanics whose effects cannot be understood through in-game observation or experimentation.
Why: LLMs implementing roguelike-style games often import complex mechanics from existing games without providing the in-game information systems that make those mechanics discoverable.
Detection: Identify the 3 most complex mechanics. For each, determine whether a player could understand it through in-game information alone. If any is opaque without external knowledge, FAIL.

**S65. Decorative ASCII Title Card**
Pattern: The game has a large ASCII art title screen or banner (10+ lines) that contains no gameplay information — purely decorative art that the player must scroll past.
Why: LLMs default to generating elaborate ASCII title cards because they've seen them in training data. These push actual game content off-screen and add nothing to the experience.
Detection: Check if the game's opening output contains a large ASCII art block before the first interactive element. If the art communicates no gameplay information and occupies >10 lines, FAIL.

**S66. Missing Spatial Display**
Pattern: The game involves spatial reasoning (navigation, positioning, layout, line of sight) but provides no visual map, grid, or diagram — all spatial information is conveyed through text descriptions only.
Why: LLMs default to text-menu interfaces even when the concept clearly implies spatial interaction. A space station infiltration game, a store layout game, or a tactical combat game without a map forces the player to build a mental model from prose.
Detection: Identify whether the game concept involves spatial decisions. Check if any visual spatial representation exists. If the concept demands spatial reasoning and the game provides no visual display, FAIL.

### XI. Code Anti-Patterns

**S67. Print Inside Simulation**
Pattern: `print()`, `input()`, or string formatting calls inside functions that compute game outcomes (combat resolution, resource calculation, AI decisions, event resolution).
Why: LLMs generate code that interleaves display and logic because their training data rarely separates them. This makes headless testing impossible and couples display to simulation.
Detection: Search for `print(` and `input(` inside functions that return game state changes (damage values, resource deltas, AI decisions). If simulation functions contain IO calls, FAIL.

**S68. Monolithic Game File**
Pattern: A single file contains >80% of the game's logic — game loop, state management, all game systems, display, and input handling in one file.
Why: LLMs default to writing everything in one file. This makes the code unnavigable, untestable, and impossible to modify one system without reading the entire program.
Detection: Count lines per file. If any single file contains >80% of total code lines (excluding data/config), FAIL.

**S69. Magic Number Proliferation**
Pattern: Numeric literals appear directly in game logic — `if hp < 20`, `damage = attack * 1.5`, `cost = 50`, `probability = 0.3` — with no named constant or config reference.
Why: LLMs scatter values throughout code because it's the shortest path to working logic. This makes balance tuning require a full codebase search.
Detection: Count numeric literals in game logic (excluding data definition files and array indices). If >20 unnamed numeric literals appear in game logic, FAIL.

**S70. Hardcoded Content**
Pattern: Game entities (items, enemies, events) are defined inline in game logic rather than in data structures. Adding a new weapon requires editing the combat function, not a data table.
Why: LLMs generate content inline because it's the path of least abstraction. This makes content impossible to extend without understanding the engine.
Detection: Check whether items, enemies, abilities, and events are defined in centralized data structures (dicts, lists, config files) or scattered as conditionals throughout game logic (`if weapon == "sword": damage = 10`). If >50% of content is defined inline in logic rather than data, FAIL.

**S71. No Debug/Test Mode**
Pattern: The game has no way to manipulate state for testing — no debug menu, no cheat commands, no console, no sandbox mode, no arena. The only way to reach a specific game state is to play through to it.
Why: LLMs never build dev tools because they aren't in the prompt's requirements. Without state manipulation, testing late-game content, edge cases, or specific scenarios requires playing through the entire game each time.
Detection: Search for debug commands, cheat codes, console interfaces, god mode, spawn commands, or any developer-facing state manipulation. If none exist, FAIL.

**S72. Non-Reproducible Randomness**
Pattern: The game uses randomness but exposes no seed, has no way to reproduce a specific game session, and doesn't log the seed used.
Why: Without reproducibility, bug reports are anecdotal — "it crashed sometimes" instead of "seed 42 crashes on turn 15." LLMs call `random.random()` without seeding or logging.
Detection: Check whether the game sets and logs a random seed. Check whether providing the same seed produces the same game. If there's no seed system or the seed isn't logged/displayed, FAIL.

**S73. Artificial Turn Limit**
Pattern: The game ends after a fixed number of turns (e.g., `if turn >= 60: game_over()`) regardless of game state or player engagement. The turn cap is not a consequence of simulation dynamics — it is an arbitrary endpoint imposed on the game.
Why: LLMs default to turn limits as the simplest way to satisfy "the game must end" and "prevent indefinite stalling." But indefinite play is fine — a game that continues as long as the player is actively making decisions has no design problem. The real anti-stall goal is making turtling suboptimal, not imposing a timer. Turn limits are artificial constraints that punish engaged players and reward passive ones equally.
Detection: Search for conditionals that end the game based on turn count, elapsed turns, or a maximum turn number. If removing the turn limit would cause the game to have no end condition at all (because no simulation-driven win/loss/failure state exists), that is a compound failure — both S73 and S5 (No Failure State). FAIL if any hard turn cap exists.

---

## Summary

| Domain | Count | Focus |
|--------|-------|-------|
| I. Hollow Core | 5 | Games that aren't actually games |
| II. Isolated Systems | 3 | Systems that don't interact |
| III. Combat Templates | 6 | Paint-by-numbers combat |
| IV. Economy Templates | 4 | Paint-by-numbers economy |
| V. Progression Templates | 6 | Numbers-go-up without change |
| VI. Info/Interface | 7 | Display and input problems |
| VII. World Autopilot | 8 | Autocomplete settings/narrative |
| VIII. Structural Autopilot | 5 | Template structures |
| IX. Untested Gameplay | 8 | Works in code, broken in play |
| X. Miscellaneous | 14 | Other red flags |
| XI. Code Anti-Patterns | 6 | Implementation quality |
| **Total** | **72** | |

### Usage Note

Sentinel checks are designed to be used in two ways:
1. **As auditor criteria** — integrated into the auditor prompts as things to look for
2. **As game creation prompt guidance** — many of these can be inverted into instructions for the game creation prompt itself (e.g., "do not use attack/defend/flee as your combat options")

The "Untested Gameplay" category (IX) is particularly important because these failures are invisible in static code analysis. The auditor MUST actually run or simulate the game to detect them.
