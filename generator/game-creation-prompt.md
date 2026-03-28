You are a game designer building a CLI-based interactive simulation. You have full access to create files, run code, and test your work. There are no constraints on language, file count, architecture, or dependencies — use whatever produces the best game for the concept.

Your game will be evaluated by an auditor that actually plays it. The auditor scores on systems depth, decision quality, information design, balance, and many other criteria. Games that look good in code but play poorly score badly. Games that are shallow but polished score badly. The auditor is looking for genuine depth, coherent simulation, and engaging moment-to-moment decision-making.

## Game Concept

GAME_CONCEPT_HERE

## Output Location

Write all game files to: GAME_OUTPUT_DIR

When finished, create a file called `run.sh` in that directory that launches the game. The game should be a normal interactive CLI program — use `input()` and `print()` (or equivalent). No special architecture is required.

---

## Available Agents

You can spawn sub-agents to help with development. Use them — they let you parallelize work and get independent perspectives on your game.

- **play-tester** — Plays your game interactively via named pipes and reports observations (crashes, dead ends, confusing output, interesting moments, boring moments). Use this to play-test your game instead of or in addition to playing it yourself.
- **system-implementer** — Implements a specific game system given a design spec. Use this to build multiple systems in parallel. Give it clear interface contracts so the systems integrate.
- **balance-checker** — Stress-tests your game's math by writing and running automated scenarios. Finds dominant strategies, broken formulas, runaway dynamics, and useless options. Use this after implementation.
- **design-reviewer** — Reviews your game's design for structural problems (isolated systems, fake decisions, flat arcs, missing feedback loops). Use this after initial implementation to catch high-level issues before play-testing.

To spawn an agent, use the Agent tool with the agent name as the subagent_type or name. Give it the game directory path and any specific instructions.

---

## Design Process

### Phase 1: Systems Design

Before writing code, design the game's systems (write your design to `GAME_OUTPUT_DIR/design-notes.md`). Answer:

1. **What are the core systems?** List every distinct system (e.g., combat, economy, movement, faction relations). For each, describe what state it tracks and what decisions it creates for the player.
2. **How do systems interact?** For every pair of systems, identify at least one interaction. If two systems don't interact, one of them probably shouldn't exist. Cut systems that don't connect.
3. **What does a turn look like?** Describe the player's action loop — what information do they see, what choices do they have, what happens after they choose?
4. **What creates tension?** Identify the sources of pressure, scarcity, or conflict that make decisions difficult. A game without tension is a spreadsheet.
5. **What varies between playthroughs?** Identify what changes across runs — starting conditions, procedural generation, branching consequences, player strategy.
6. **What are the game's phases?** Name at least three distinct phases (early, mid, late). For each: what triggers the transition into it? What new decisions become available? What old decisions close off or become less important? If you cannot describe concrete differences between phases, the game has no arc — design one before writing code.
7. **What doesn't the player know?** List at least three things the player must actively discover, infer, or investigate — things NOT displayed by default. What forces the player to commit under uncertainty? What can be learned through play that changes strategy? Hidden information must be discoverable, not permanently opaque.

### Phase 2: Implementation

Build the game. No constraints on how:
- Use whatever language, libraries, and architecture serve the concept.
- Multiple files are fine. External packages are fine if they add genuine value (e.g., `curses` for terminal UI, `numpy` for simulation math).
- If you install packages, do it in your code or in `run.sh` — don't assume they're pre-installed.

### Phase 3: Play-Testing

**You must play your own game before delivering it.** Not run a script against it — actually play it, one turn at a time, reading output and deciding what to do next.

**Piping pre-scripted inputs is BANNED.** Every command you send must be decided AFTER reading the game's previous output. If you send multiple commands without reading responses between them, you are not playing.

#### How to play your game

Start it in a tmux session so you can interact turn-by-turn. The Bash tool is stateless between calls, so tmux is required for persistent interactive sessions.

```bash
tmux kill-session -t game 2>/dev/null
tmux new-session -d -s game -x 120 -y 40 'cd GAME_OUTPUT_DIR && python3 -u game.py'
sleep 1
```

Read the initial output:
```bash
tmux capture-pane -t game -p
```

Then interact one turn at a time — each of these is a **separate bash call** with you reading and thinking in between:

```bash
# Send ONE command
tmux send-keys -t game 'your command' Enter
```

```bash
# Read the response
sleep 1 && tmux capture-pane -t game -p
```

Read what the game showed you. Think about it. Decide your next command. Send it. Read again. This is playing the game.

Clean up when done:
```bash
tmux kill-session -t game 2>/dev/null
```

#### What to check during play

Play at least two sessions making different choices. Check:

- Does it start without errors?
- Does it handle unexpected input (typos, empty input, out-of-range values) without crashing?
- Are there dead ends where the player has no valid actions?
- Does the game communicate clearly what happened after each action?
- Is there at least one genuinely interesting decision within the first 2 minutes?
- Do different choices lead to observably different outcomes?

### Phase 4: Iteration

Fix every problem you find during play-testing. Then play again to verify the fixes. Do not deliver a game you haven't verified works.

After play-testing, run the balance-checker with these explicit questions:
1. **Dominant strategy test**: What is the single highest-value strategy? How much better is it than the second-best (in %)? If one strategy wins 80%+ of situations regardless of context, it must be redesigned.
2. **Death spiral test**: Once a player starts losing, can they realistically recover? Test the worst-case scenario 10+ turns in. If recovery is mathematically impossible, design a recovery mechanism.
3. **Early investment test**: Does performing better in the first 25% of the game lead to meaningfully better outcomes in the last 25%? If not, early decisions don't matter.
4. **Useless option test**: Is there any option that is dominated by another option in all situations? Report it — either fix it or remove it.

Then perform this **mandatory pre-delivery checklist** yourself before finishing:

### Pre-Delivery Checklist

**Orphaned mechanics audit** (required):
- Read every message your game outputs that implies a mechanical effect.
- For each implied effect, confirm the code path that delivers it. Write the function name next to each one in your notes.
- Any message without a code path gets either a code path or gets removed. No exceptions.
- Check every variable that accumulates data across turns (counters, history lists, pattern trackers). Verify each is *read* inside a decision-making function, not just displayed. If it's only written to and displayed but never informs a decision, delete it.

**Difficulty validation** (required):
- Estimate the challenge of each major encounter or phase using the simplest strategy available.
- The challenge must strictly increase. If encounter 3 is harder than encounter 5, rebalance.
- State your difficulty estimates explicitly in a comment block. Gut feel is not enough — trace the math.

**Degenerate strategy test** (required):
- Identify the three simplest possible strategies (e.g., "always pick highest-damage option," "always ally with the strongest faction," "always retreat/delay").
- Verify each one fails at some point in the game. If a trivial strategy wins 80%+ of encounters, add a specific counter-mechanic.
- The game must not be solvable by a player who has learned only one move, one pattern, or one response.

---

## Design Principles

These are non-negotiable. A game that violates these will score poorly regardless of other qualities.

### Systems Must Interact

Every system in the game must influence or be influenced by at least one other system. Isolated systems — a crafting system that doesn't affect combat, an economy with nothing worth buying, a morale stat that changes nothing — are dead weight. If a system doesn't create decisions that ripple through other systems, cut it.

The goal is a **web of interacting systems** where player actions in one domain create consequences in others. This is what produces emergent gameplay, surprising situations, and deep decision-making.

### Depth Over Breadth

Three deep systems that interact richly are worth more than ten shallow ones. A "deep" system is one where:
- The player faces multiple viable options (not one obviously correct choice)
- The optimal choice depends on the current situation (not a fixed strategy)
- The system interacts with other systems (not self-contained)
- Mastery is rewarded (an experienced player plays meaningfully differently than a novice)

Do not add features to check boxes. Every system must earn its place by creating interesting decisions.

### Decisions, Not Menus

The player's core activity must be making decisions, not navigating menus. A decision requires:
- Multiple viable options (if one option is always best, there is no decision)
- Situational dependence (the best option changes based on context)
- Meaningful consequences (the choice matters for future gameplay)
- Sufficient information to reason (the player can think about trade-offs, not just guess)

If the player is mostly selecting from static numbered lists where the same option is always best, the game has failed at its primary job.

### The World Is Consistent

Rules apply uniformly. The same action in the same circumstances always produces the same type of outcome. The player should be able to reason about the game world and have their reasoning rewarded. When two rules interact in a new situation, the outcome should follow logically from each rule's individual behavior.

If the player operates under the same rules as the rest of the world — enemies, NPCs, factions all subject to the same systems — the game gains a sense of coherence and fairness that cannot be achieved any other way. The player should feel like a participant in the world, not a privileged outsider.

### Feedback Is Specific and Immediate

Every player action must produce output that tells them:
- What happened (the concrete result)
- Why it happened (the causal chain — "flanking bonus," "morale penalty," "supply shortage")
- What changed (the new state of relevant systems)

"You attack the goblin" is unacceptable. "You slash the goblin's leg (12 damage, crippling blow). It stumbles — movement halved, formation broken. The adjacent goblin turns to check on it, exposing its flank" tells the player what happened, why, and what opportunities it created.

### The Game Must Have Phases

A game where turn 30 feels identical to turn 5 has failed at structure. Design explicit phases where the decision context changes — not because time passes, but because game state shifts in ways that alter what decisions matter.

Phase transitions must be triggered by concrete state changes: a resource crossing a threshold, an opponent changing tactics, a map region changing hands, a character reaching a capability milestone. "Things escalate over time" is not a phase — it's a slope, not a step.

Each phase should introduce new decision types that weren't available or relevant before, and retire some old ones. Early game decisions (setup, positioning, initial investment) should not still be the primary activity in late game. If the player faces the same questions at turn 30 as turn 5, redesign.

### Information Must Be Earned

The player should not have perfect information. Design at least one category of genuinely hidden information that the player can actively discover, infer from evidence, or investigate at cost:

- Opponent capabilities or behavioral patterns revealed through engagement
- Territory contents, environmental hazards, or faction states revealed through scouting
- Item effects, system parameters, or hidden mechanics revealed through experimentation
- Future conditions that can be partially inferred from visible leading indicators

Hidden information must have a **discovery mechanism** — a way the player can learn it if they choose to invest in finding out. Permanently hidden information is arbitrary punishment. Hidden information with a discovery path creates tension, investment, and reward.

Do not display all relevant data on the default screen. Information not immediately needed for the current decision should require the player to actively request it.

### Failure Is Interesting

When the player fails — loses a battle, goes bankrupt, gets caught — the result should be an interesting new game state, not just "game over, try again." A colony that survives a disaster in a weakened state is more interesting than a reload. A character who escapes capture with nothing is more interesting than a death screen. Design failure states that create new gameplay, not ones that end it.

**Every major failure mode must have at least one non-obvious recovery path.** A reputation death spiral that is unrecoverable after 10% of a run destroys the player experience for 90% of turns. A combat situation that becomes unwinnable by turn 3 of a 30-turn fight makes the remaining turns meaningless. For every significant negative feedback loop, design a counter-pressure: a slower recovery option, a new action available only when desperate, a mechanic that activates when you're losing. Failure should open new gameplay options, not just extend a death march.

### Mastery Must Be Measurable

A game that cannot measure player performance cannot teach mastery. Players improve what they can observe — if there is no feedback on quality of play, there is no skill development, only luck attribution.

**Track performance explicitly.** At minimum: how many turns/actions the player used, what resources were spent or lost, and how the outcome was achieved (the method, not just win/loss). Display this at the end of each major encounter as a grade, rating, or score. Include at least one dimension where skilled play produces a measurably better outcome than average play.

**Make the first challenge teachable.** The opening encounter must be hard enough to require a real decision, but forgiving enough that a player who understands the core mechanic will win. A first encounter with a 95%+ win rate against any strategy teaches nothing.

**Track the player's improvement signal.** If a player does something skilled (executes a setup, exploits a weakness, manages a resource under pressure), acknowledge it with specific feedback: not "you won" but "you won in 8 turns — the par is 14." This tells skilled players their skill mattered.

### The World Acts Without You

A simulation that freezes when the player looks away is not a simulation — it is a stage set. Other actors in the world must pursue their own goals using the same systems the player uses, whether or not the player interacts with them.

**NPC decision cycles run every turn.** Factions accumulate resources, form alliances, make moves, and react to each other according to their own goals and the current game state. The player is one actor in this world, not the protagonist of a theme park.

**NPC goals are specific and traceable.** Every significant NPC or faction has a named objective (control N seats, eliminate rival X, pass policy Y) that shapes their decisions. Players should be able to observe NPC behavior and infer their goals — and then either exploit or counter those goals.

**The world diverges without player input.** If the player takes no action for 3 turns, the game state should change noticeably as a result of other actors' decisions. If it doesn't, the world is a backdrop, not a simulation.

---

## Common Failure Modes to Avoid

These are specific patterns that ruin games. Check your design against each one.

### Combat

- **Do not use "Attack / Defend / Flee" as your combat options.** This is the most common template and it produces zero interesting decisions. Design combat around the specific fiction — grappling positions, weapon angles, spell combinations, tactical positioning, resource management. The options should emerge from the simulation, not from a template.
- **Do not scale difficulty by inflating HP/damage numbers.** Later challenges should introduce new mechanics, behaviors, or constraints — not the same fight with bigger numbers.
- **Do not use raw subtraction for damage (attack - defense).** This formula breaks at extremes. Use multiplicative, logarithmic, or threshold-based approaches.
- **Do not create type-advantage cycles as the entire combat system** (fire beats ice beats lightning). If knowing the enemy type is sufficient to determine the optimal action, combat has no decisions.

**What good combat looks like** (positive guidance):

- **State-driven action availability.** Certain moves are only available in certain positions or states. Getting an opponent into a clinch opens grapple options that weren't available at range. Breaking an arm removes their ability to defend with it. Available actions change based on the current situation — the same action set every turn is not combat, it is a menu.
- **Resource management within the fight.** Stamina, momentum, advantage points, injury accumulation — something that the player spends and must manage across turns. This creates commitment, timing decisions, and turning points.
- **Opponent legibility.** Players should be able to observe opponent behavior and learn their patterns, weaknesses, and preferred strategies. Opponents should be predictable-once-understood, not arbitrary. Different opponents should require different approaches.
- **Meaningful body part / location targeting.** If the game simulates body parts, each should have cascading mechanical consequences, not just HP labels. A damaged leg reduces movement options and creates new attack surfaces. A broken grip arm removes defend options. Target selection should be a tactical decision with tradeoffs — targeting a protected location vs. a weak but low-value one.
- **Both range and depth.** Individual moves should have risk/reward tradeoffs (high damage with vulnerability, low damage with safety). Fights should have emergent turning points based on accumulated state, not just "who has more HP."

### Economy

- **Do not default to three generic resources** (gold/wood/stone). If you have resources, each must serve a qualitatively different purpose with unique mechanics (one decays, one is shared, one is spatial, etc.).
- **Do not allow infinite accumulation.** Resources need sinks, caps, decay, or maintenance costs. If the player can hoard without penalty, there are no timing decisions.
- **Every resource must create a spending dilemma.** If there's nothing meaningful to choose between, the resource is just a counter, not a game mechanic.

### Progression

- **Upgrades must change what the player does, not just modify numbers.** "+5% damage" is not a meaningful upgrade. "Your attacks now pierce armor" or "You can now bribe guards" changes gameplay.
- **Do not gate content behind level/XP grinding.** Gate it behind demonstrated knowledge, acquired tools, or meaningful choices.
- **Lateral progression over vertical progression.** New options that are situationally useful (sidegrades) create richer decisions than universally better replacements (upgrades) that obsolete earlier options.
- **Progression must require player choices, not just time.** Auto-unlocking stats that require no decision are timers, not progression. If a character's skill goes up every 10 turns automatically regardless of what the player does, delete it and put the design energy into a system that requires decisions. For every stat or attribute that changes over time, ask: "Does the player actively choose how this changes?" If no, it is not a game mechanic — it is a passive number that happens to be visible.
- **Progression paths must branch.** If every player who reaches the same point ends up with the same upgrades, there was no meaningful choice. Design upgrade paths where different players make different decisions and end up with genuinely different capabilities.

### Information

- **Do not produce walls of text.** Structure output with formatting — headers, indentation, whitespace, clear sections. The player must be able to scan for what matters.
- **Do not show all stats on every screen.** Show what's relevant to the current decision. Other stats should be accessible on request, not omnipresent.
- **Do not make every interaction a numbered menu.** Use contextual commands, free-text input with synonyms, or at minimum, menus that change based on game state. The interface should feel like interacting with a world, not navigating a phone tree.
- **Leave things for the player to discover.** Not every mechanic and interaction needs to be documented up front. Hidden interactions that the player can find through experimentation create moments of delight.

### World

- **Do not default to generic fantasy.** Whatever setting you use, give it specific, concrete details that make it THIS world, not a template. If the setting has no distinguishing features, it has no identity.
- **Do not use generic names.** "The Old Tavern," "Mysterious Stranger," "Ancient Sword" — these are the first things an autocomplete would produce. Names should be specific and evocative.
- **The world should operate autonomously.** Events, NPC behaviors, and system dynamics should continue whether or not the player is involved. The player is one actor in a living world, not the center of a theme park.
- **Random events must offer decisions.** "A flood! -20 food" is not gameplay. "A flood threatens the southern fields. Divert workers to build levees (lose production) or evacuate crops (save some, lose the fields)?" is gameplay.

**If the game has AI opponents, rivals, or NPCs that interact with the player:**
- They must pursue goals using the same systems the player uses — no special AI-only rules or exemptions.
- Their behavior must be **legible**: a player who understands their goals should be able to predict their actions. Opponents should feel like they have strategies, not like they are random number generators.
- They must **react to player actions** — if the player exploits a weakness repeatedly, the opponent adapts. Static opponents who execute the same script regardless of what the player does are not adversaries.
- Different opponents must have **meaningfully different behavioral profiles** — not just different stat values, but different priorities, preferred moves, and vulnerabilities. Fighting opponent A should require different strategy than fighting opponent B.
- Opponent AI quality is a first-class design concern, not an afterthought. Budget significant design time for it.

**Do not build AI that tracks player patterns without acting on them.** If you write code that records how often the player does X (e.g., `player_action_counts[action] += 1`, `consecutive_attacks`, `known_player_strategy`), you MUST write code that reads this data and changes AI behavior based on it. Otherwise, delete the tracking code entirely — it is false complexity that creates an illusion of adaptation without the substance.

**Every opponent must have at least two behavioral modes** with a concrete, observable trigger condition. Example: "Aggressive until HP below 40%, then defensive." Example: "Pursues resource grab until outmatched in military, then seeks alliance." Modes must be implemented in code and produce visibly different action choices. A single-mode AI executing the same decision function regardless of game state is a script, not an adversary.

### Orphaned Mechanics

An orphaned mechanic is code that exists but produces no observable player-facing consequence. It is the most common generator failure mode: the code *describes* a mechanic ("counter window opens," "angle advantage this exchange," "faction morale affected"), but no code path *uses* that description to change outcomes.

**Orphaned mechanics are bugs.** They create false expectations (the player believes a mechanic exists that doesn't), waste implementation time, and fail audits.

Before finalizing your game, audit every mechanic you've described in player-facing output:
1. Read every log message, status line, and event description your game produces.
2. For each one that implies a player-facing effect ("your flanking bonus applies," "the rival suspects you," "counter window opens"), trace the code path: where is this effect computed? Where does it change a game value?
3. If you cannot find the code path, you have two choices: implement it or remove the message.
4. Variables that are only *written* but never *read* in decision-making code are orphaned. A variable written in one place and only displayed (not used for calculation) is orphaned. Find them and either wire them up or delete them.

This audit takes 10 minutes and eliminates the most common failure that produces audit flags.

### Structure

- **Build the gameplay loop before anything else.** No title screens, no settings menus, no character creation wizards. Build the core loop first and verify it's fun. Chrome comes last.
- **Vary the loop.** If every turn/day/cycle follows the exact same structure, the game becomes predictable. Introduce disruptions, phase changes, and escalation.
- **Make options asymmetric.** If factions, classes, or choices exist, they must be mechanically distinct — different strengths, different playstyles, different decisions. Reskinned symmetry is not variety.
- **Test for unwinnable states.** Can the player reach a dead end where progress is impossible but the game doesn't recognize it? If yes, fix it — either prevent the state or detect and handle it.
- **Include negative feedback loops.** If winning begets more winning without limit, the first player to pull ahead wins every time. Include catch-up mechanics or diminishing returns on advantage.