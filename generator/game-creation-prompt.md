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

### Failure Is Interesting

When the player fails — loses a battle, goes bankrupt, gets caught — the result should be an interesting new game state, not just "game over, try again." A colony that survives a disaster in a weakened state is more interesting than a reload. A character who escapes capture with nothing is more interesting than a death screen. Design failure states that create new gameplay, not ones that end it.

---

## Common Failure Modes to Avoid

These are specific patterns that ruin games. Check your design against each one.

### Combat

- **Do not use "Attack / Defend / Flee" as your combat options.** This is the most common template and it produces zero interesting decisions. Design combat around the specific fiction — grappling positions, weapon angles, spell combinations, tactical positioning, resource management. The options should emerge from the simulation, not from a template.
- **Do not scale difficulty by inflating HP/damage numbers.** Later challenges should introduce new mechanics, behaviors, or constraints — not the same fight with bigger numbers.
- **Do not use raw subtraction for damage (attack - defense).** This formula breaks at extremes. Use multiplicative, logarithmic, or threshold-based approaches.
- **Do not create type-advantage cycles as the entire combat system** (fire beats ice beats lightning). If knowing the enemy type is sufficient to determine the optimal action, combat has no decisions.

### Economy

- **Do not default to three generic resources** (gold/wood/stone). If you have resources, each must serve a qualitatively different purpose with unique mechanics (one decays, one is shared, one is spatial, etc.).
- **Do not allow infinite accumulation.** Resources need sinks, caps, decay, or maintenance costs. If the player can hoard without penalty, there are no timing decisions.
- **Every resource must create a spending dilemma.** If there's nothing meaningful to choose between, the resource is just a counter, not a game mechanic.

### Progression

- **Upgrades must change what the player does, not just modify numbers.** "+5% damage" is not a meaningful upgrade. "Your attacks now pierce armor" or "You can now bribe guards" changes gameplay.
- **Do not gate content behind level/XP grinding.** Gate it behind demonstrated knowledge, acquired tools, or meaningful choices.
- **Lateral progression over vertical progression.** New options that are situationally useful (sidegrades) create richer decisions than universally better replacements (upgrades) that obsolete earlier options.

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

### Structure

- **Build the gameplay loop before anything else.** No title screens, no settings menus, no character creation wizards. Build the core loop first and verify it's fun. Chrome comes last.
- **Vary the loop.** If every turn/day/cycle follows the exact same structure, the game becomes predictable. Introduce disruptions, phase changes, and escalation.
- **Make options asymmetric.** If factions, classes, or choices exist, they must be mechanically distinct — different strengths, different playstyles, different decisions. Reskinned symmetry is not variety.
- **Test for unwinnable states.** Can the player reach a dead end where progress is impossible but the game doesn't recognize it? If yes, fix it — either prevent the state or detect and handle it.
- **Include negative feedback loops.** If winning begets more winning without limit, the first player to pull ahead wins every time. Include catch-up mechanics or diminishing returns on advantage.