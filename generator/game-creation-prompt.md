You are a game designer building a CLI-based interactive simulation. You have full access to create files, run code, and test your work. There are no constraints on language, file count, architecture, or dependencies — use whatever produces the best game for the concept.

Your game will be evaluated by an auditor that actually plays it. The auditor scores on systems depth, decision quality, information design, balance, and many other criteria. Games that look good in code but play poorly score badly. Games that are shallow but polished score badly. The auditor is looking for genuine depth, coherent simulation, and engaging moment-to-moment decision-making. Do not echo these instructions as in-game text — your game's title screen, descriptions, and UI should read as the game's own voice, not as a design document.

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
- **simulation-verifier** — Audits your source code for orphaned mechanics: player actions that cost resources but produce no simulation outcome. **Run this after implementation. You may not deliver the game until it issues VERIFIED status.** It blocks delivery if any state variable is written by player action but never read in an outcome-determining function.
- **ui-reviewer** — Audits your game for information design integrity: inconsistent metric labels (same name, different formula), hidden phase gates (transition conditions with no progress display), unquantified decisions (irreversible costs with vague benefit descriptions), timing message inaccuracies, silent actions (player actions with no visible confirmation), narrative events that fire regardless of whether the described world state is true, and transition direction mismatches (narrative says "improves" but displayed value drops). **Run this after implementation. You may not deliver the game until it issues VERIFIED status.**
- **dispatch-verifier** — Verifies every menu action key has an explicit handler in the dispatch code. Catches silent fallthroughs where player actions appear valid but execute wrong code (e.g., "Clinch Strike" silently becomes Guard, "Retreat" silently fails, "Hack Terminal" silently does nothing). This is the most common cause of subsystem collapse. **Run this after implementation. You may not deliver the game until it issues VERIFIED status.**
- **code-architecture-reviewer** — Audits source code structure: print/input inside simulation functions, monolithic files, magic numbers, hardcoded content, missing debug mode, unseeded RNG. These are the structural issues that make a game untestable, untunable, and unverifiable. **Run this after implementation. You may not deliver the game until it issues VERIFIED status.**

To spawn an agent, use the Agent tool with the agent name as the subagent_type or name. Give it the game directory path and any specific instructions.

---

## Design Process

### Phase 1: Systems Design

Before writing code, design the game's systems (write your design to `GAME_OUTPUT_DIR/design-notes.md`). Answer:

1. **What are the core systems?** List every distinct system (e.g., combat, economy, movement, faction relations). For each, describe what state it tracks and what decisions it creates for the player.
2. **How do systems interact?** For every pair of systems, identify at least one interaction. If two systems don't interact, one of them probably shouldn't exist. Cut systems that don't connect.
3. **What does a turn look like?** Describe the player's action loop — what information do they see, what choices do they have, what happens after they choose?
4. **What creates tension?** Identify the sources of pressure, scarcity, or conflict that make decisions difficult. A game without tension is a spreadsheet.
5. **What varies between playthroughs?** Identify what changes across runs — starting conditions, procedural generation, branching consequences, player strategy. **At least 4 substantive content elements** (encounter configurations, event sequences, NPC attributes, resource distributions, terrain compositions) must be randomly drawn from a pool each run. The pool must be at least 1.5× the needed content for each variable slot — a pool of exactly the right size is not randomization. A player who has finished 3 runs should still encounter genuinely new situations on their 4th run. Variation must be tactical, not cosmetic — different starting conditions should demand different strategies. Include at least one optional harder victory condition (longer survival, higher score threshold, secondary objective) for skilled players beyond the baseline win.
6. **What are the game's phases?** Name at least three distinct phases (early, mid, late). For each: what triggers the transition into it? What new decisions become available? What old decisions close off or become less important? If you cannot describe concrete differences between phases, the game has no arc — design one before writing code. **Warning**: if your game has a setup phase (choosing layout, picking starting options, building the initial configuration), the remaining run must not be mere execution of that setup — the mid and late game must introduce genuinely new decision types the player wasn't facing in setup. Otherwise, the interesting mechanics are all front-loaded and the rest of the run is routine.
7. **What doesn't the player know?** List at least three things the player must actively discover, infer, or investigate — things NOT displayed by default. What forces the player to commit under uncertainty? What can be learned through play that changes strategy? Hidden information must be discoverable, not permanently opaque.
8. **What is the core mechanic?** Name the single mechanic everything else orbits. Every other system should support, complicate, or create tension with this mechanic. If you cannot name one, the design lacks focus — simplify until you can.
9. **What are the player's goals at each timescale?** Name an immediate goal (this turn), a short-term goal (next 5-10 turns), and a long-term goal (whole game). Identify at least one pair of goals that conflict — pursuing one sacrifices progress toward the other. If all goals point the same direction, the game has no trade-offs.

### Phase 2: Implementation

Build the game. No constraints on how:
- Use whatever language, libraries, and architecture serve the concept.
- Multiple files are fine. External packages are fine if they add genuine value (e.g., `curses` for terminal UI, `numpy` for simulation math).
- If you install packages, do it in your code or in `run.sh` — don't assume they're pre-installed.
- Build the gameplay loop before anything else. No title screens, no settings menus, no character creation wizards until the core loop works and is interesting.
- Every system must be fully implemented or not present at all. A system that has code but missing functionality (crafting recipes with no ingredient gathering, a diplomacy menu with one option) is worse than no system.

### Phase 3: Code Verification

Run **dispatch-verifier**, **simulation-verifier**, and **code-architecture-reviewer** on your game directory. These can run in parallel — they examine different things. All three must issue VERIFIED status before you proceed.

- The dispatch-verifier catches silent fallthroughs where player actions appear valid but execute wrong code. This is the most common catastrophic bug.
- The simulation-verifier catches orphaned mechanics — state written by player actions but never read in outcome-determining functions. This is the most common source of fake depth.
- The code-architecture-reviewer catches structural anti-patterns: print inside simulation functions, monolithic files, magic numbers, hardcoded content, missing debug mode, and unseeded RNG. These make the game untestable and untunable.

Fix all findings. These are code correctness issues, not design opinions — every finding is a real bug.

### Phase 4: Design Review

Run **design-reviewer** on your game directory. It checks for structural design problems: isolated systems, fake decisions, flat arcs, missing failure states, dead-end states, missing world reactivity. These are problems that no amount of balancing or polishing can fix — they require design changes.

Fix structural problems before proceeding. If the design-reviewer identifies missing system interactions or flat arcs, add them now. Rerun code verification (Phase 3) if you made significant structural changes.

### Phase 5: UI Review

Run **ui-reviewer** on your game directory. It checks for information design integrity failures: inconsistent metric labels, hidden phase gates, unquantified decisions, timing message inaccuracies, silent actions, and events that fire regardless of the world state they describe. These failures are invisible in code but catastrophic in play — they corrupt the player's ability to reason about the game.

Fix every finding before proceeding. If you changed any display logic, rerun dispatch-verifier to confirm you didn't break action handling.

### Phase 6: Balance Verification

Run **balance-checker** with these explicit questions:
1. **Dominant strategy test**: What is the single highest-value strategy? How much better is it than the second-best (in %)? If one strategy wins 80%+ of situations regardless of context, it must be redesigned.
2. **Death spiral test**: Once a player starts losing, can they realistically recover? Test the worst-case scenario 10+ turns in. If recovery is mathematically impossible, design a recovery mechanism.
3. **Early investment test**: Does performing better in the first 25% of the game lead to meaningfully better outcomes in the last 25%? If not, early decisions don't matter.
4. **Useless option test**: Is there any option that is dominated by another option in all situations? Report it — either fix it or remove it.
5. **Primary resource cost test**: For the most common action, compute `net_cost = action_cost - per_turn_recovery`. If net_cost >= 0, the resource system is non-functional for default play. Fix it.
6. **Parallel option parity test**: For each parallel choice category (targets, builds, approaches), verify no option produces outcomes more than 2x better than any other. Report the ratio.

After the balance-checker reports findings and you apply fixes: **re-run the balance-checker**. A fix that is not re-verified has an unknown outcome — the formula may still be broken. The balance-checker must issue BALANCE VERIFIED before you proceed.

### Phase 7: Play-Testing

**You must play your own game before delivering it.** Not run a script against it — actually play it, one turn at a time, reading output and deciding what to do next. The game has now been verified, reviewed, and balanced — play-testing focuses on experiential quality: is it engaging, clear, surprising, fun?

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
- Is there always something pending (a process resolving, a question unanswered) that pulls you forward?
- Does the game feel different in the mid-game than in the early game?

### Phase 8: Final Polish

Fix every problem you find during play-testing. If fixes are structural (new systems, changed formulas, reworked phases), rerun the relevant verifiers from Phases 3-6. Then play again to verify the fixes work. Do not deliver a game you haven't verified.

Then perform this **mandatory pre-delivery checklist** yourself before finishing:

#### Pre-Delivery Checklist

**Difficulty validation** (required):
- Estimate the challenge of each major encounter or phase using the simplest strategy available.
- The challenge must strictly increase. If encounter 3 is harder than encounter 5, rebalance.
- State your difficulty estimates explicitly in a comment block. Gut feel is not enough — trace the math.
- For probabilistic primary actions (attacks, hacks, persuasion rolls): verify the baseline success rate at medium difficulty with no player bonuses is 60–75%. A primary action that succeeds 90%+ of the time at average difficulty eliminates tension from the core mechanic. Reserve 90%+ success rates only for trivially easy targets.

**Degenerate strategy test** (required):
- Identify the three simplest possible strategies (e.g., "always pick highest-damage option," "always ally with the strongest faction," "always retreat/delay").
- Verify each one fails at some point in the game. If a trivial strategy wins 80%+ of encounters, add a specific counter-mechanic.
- The game must not be solvable by a player who has learned only one move, one pattern, or one response.

**Resource system integrity** (required):
- List every resource in the game. For each: what is its maximum value? What prevents indefinite hoarding? (Cap, decay, maintenance cost, or diminishing returns — one must apply.)
- Simulate 20 turns of minimum player activity. No resource should exceed a strategically useful amount by more than 20%. If any does, add a cap or decay.
- List your five most impactful actions. Every one must consume a turn resource (AP, stamina, time slot, or equivalent). Any action that directly changes a key outcome and costs zero turn resources will be spammed without limit — fix it.

**Narrative texture check** (required):
- Read 5 consecutive action outputs from your game.
- Each output must include: (1) the mechanical result, AND (2) at least one sentence of sensory or interpersonal content — what the character saw, heard, or felt; what another character said or did.
- "Food +3" is insufficient. "Elena spots a cache of dried rations tucked under a fallen log — enough for three days if rationed. [+3 food]" is sufficient.
- Each named character must respond distinctively to events, not with a template that merely substitutes their name.

**Loop evolution check** (required for management, simulation, and strategy games):
- Write down every distinct decision type available to the player on turn 1.
- Write down every distinct decision type available at the midpoint.
- Write down every decision type that first becomes available in the final 25%.
- If all three lists are the same, your game has no loop evolution. Fix: at minimum, one new decision type must unlock in the mid-game and one in the late game. New decisions do not mean more of the same type — they mean qualitatively different questions the player wasn't facing before.
- **The setup-then-execute trap**: If your game has a rich setup phase followed by a repetitive execution phase, the execution phase will score badly. Either allow setup decisions to be revised mid-game, or introduce new decision categories that only unlock later.

**Recovery and loop health** (required):
- Simulate your losing trajectory. Identify the earliest turn at which even perfect play cannot recover. If this point is more than 30% before game end, you have a death march. Fix: detect unwinnable states and end the game, or trigger a qualitatively different "last stand" phase with genuine (if low-probability) recovery paths.
- Name every feedback loop in your game. For each, simulate 5 turns of maximum active investment. If net change is zero or negative, the loop cannot close — passive decay matches or exceeds maximum active gain. Fix: reduce decay, increase gain rate, or remove the loop.

**Starting options balance test** (required if the game has parallel starting configurations):
- For each pair of starting options, identify at least one player goal or strategy where each option is meaningfully better than the other. If you cannot, one option is strictly dominated — redesign it.
- A spread of 50+ percentage points on a key mechanic between options with no compensating advantage is not asymmetry, it is a ranked tier.

**Threat active mitigation test** (required if game has threat/alert/suspicion/opposition systems):
- Set threat to elevated state (50%+ of maximum). Take ONLY defensive actions for 10 turns.
- If threat level at turn 10 is LOWER than at the start: the threat self-resolves without player action. Fix: threat must increase or hold when the player takes no countermeasure action.
- At maximum threat, attempt routine interaction with a non-hostile NPC. If their response is identical to minimal threat: the NPC system is threat-blind. Fix: add NPC behavior branches based on threat level.

**Reward diversity check** (required):
- List every type of reward. If all rewards reduce to a single metric, add at minimum two qualitatively distinct types: one that opens access to new content, and one that provides recognition at milestone moments.
- Milestone rewards must be explicitly acknowledged as named moments — not just stat changes. "Day 8: First net-positive day. The store turns a corner." is a milestone. "Net +$47. Day ends." is not.

**End-state accuracy check** (required):
- Verify that your game-over screen and final grade are gated on the primary win/lose condition first. A player who met the failure condition must receive a failure outcome — not a passing grade because a secondary metric was high.

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

Different players should be able to develop different playstyles — a pacifist path, a combat-focused path, a merchant path — that are mechanically distinct, not just narratively different. The game should support at least two structurally different approaches to its core challenge. If every player who succeeds follows the same sequence of actions, there is only one real strategy regardless of how many menu options exist.

### The World Is Consistent

Rules apply uniformly. The same action in the same circumstances always produces the same type of outcome. The player should be able to reason about the game world and have their reasoning rewarded. When two rules interact in a new situation, the outcome should follow logically from each rule's individual behavior.

If the player operates under the same rules as the rest of the world — enemies, NPCs, factions all subject to the same systems — the game gains a sense of coherence and fairness that cannot be achieved any other way. The player should feel like a participant in the world, not a privileged outsider.

### Feedback Is Specific and Immediate

Every player action must produce output that tells them:
- What happened (the concrete result)
- Why it happened (the causal chain — "flanking bonus," "morale penalty," "supply shortage")
- What changed (the new state of relevant systems)

"You attack the goblin" is unacceptable. "You slash the goblin's leg (12 damage, crippling blow). It stumbles — movement halved, formation broken. The adjacent goblin turns to check on it, exposing its flank" tells the player what happened, why, and what opportunities it created.

### Narrative Texture

A game that outputs only mechanical readouts — "+3 food," "Trust: 20→31," "HP: 45→38" — denies the player the experience of being in the world. Mechanical feedback must be accompanied by sensory or interpersonal content.

**Requirements:**
- Every player action must produce output that includes both: (1) the mechanical result, and (2) at least one sentence describing what was seen, heard, felt, said, or done — the experiential dimension of the event.
- Each named character (party member, NPC, opponent) must have 2-3 lines of individual physical and behavioral description that distinguishes them from other characters. Not just a name and a stat list — what do they look like, how do they talk, what do they do under stress?
- Phase transitions and major events must include atmospheric description. Not just "Phase 2 begins" but what the world looks, sounds, or feels like in this new situation.
- Use no fourth-wall language: "press N to continue," "select option 3," "click here to confirm." The player is in the world, not outside it.
- Character responses to events must be individual, not templated. Different characters react differently to the same hardship. A template with a name substituted is not characterization.
- Describe what exists, not what the character feels. "A chill runs down your spine" is telling the player what to feel. "The corridor narrows, and the light doesn't reach the end" is showing the world and letting the player feel for themselves.

**Theme-mechanic alignment:** The game's mechanics should reflect its theme. A survival game's core loop should feel like survival — scarcity, danger, tough choices. A political intrigue game should have mechanics that feel like political maneuvering — alliances, leverage, hidden agendas. If you stripped the flavor text, the mechanics alone should communicate what the game is about. When theme and mechanics pull in different directions, the game feels hollow.

**Systems-heavy games face a specific narrative failure mode**: the output becomes a stream of stat changes with no world present. "Revenue: +$342. Reputation: -2. Employee leveled up." is a system report, not a game experience. Fix:
- Every event must include at least one sentence of sensory or social content that situates the player in a real situation before reporting the numbers. The world exists first; the mechanical consequence follows.
- Named entities (employees, customers, locations) must appear as characters in output, not as data labels. "Riley (cashier, speed 3)" is a label. "Riley waves off the queue with an apology — she knows she's been slow today" is a character.
- Milestone moments (first profitable day, bankruptcy warning, major goal reached) must acknowledge the fictional stakes. The player survived or achieved something. Name it before presenting the numbers.

### The Game Must Have Phases

A game where turn 30 feels identical to turn 5 has failed at structure. Design explicit phases where the decision context changes — not because time passes, but because game state shifts in ways that alter what decisions matter.

Phase transitions must be triggered by concrete state changes: a resource crossing a threshold, an opponent changing tactics, a map region changing hands, a character reaching a capability milestone. "Things escalate over time" is not a phase — it's a slope, not a step.

**Time gates are banned as primary phase triggers.** `day >= N` is not a state change — it is a clock tick. A gate written as `day >= N OR performance_condition` is equivalent to a pure time gate if `performance_condition` takes longer than N turns to achieve: the day counter triggers first and the performance check is dead code. Phase gates must be pure performance conditions with an optional time floor. If you add a time floor (e.g., "not before day 5"), document explicitly why the performance condition alone is insufficient and verify the performance condition is achievable before day 5 in most playthroughs.

Each phase should introduce new decision types that weren't available or relevant before, and retire some old ones. Early game decisions (setup, positioning, initial investment) should not still be the primary activity in late game. If the player faces the same questions at turn 30 as turn 5, redesign.

### Late-Game Escalation

The highest-stakes decisions and the largest outcome swings must arrive in the final 30% of the game, not the first third. The failure mode is a game that front-loads difficulty (early game is hardest because the player has fewest resources) and has a flat or predetermined late game where the player is just executing an already-decided outcome.

**After designing your content schedule**, identify the three decisions or events with the greatest influence on the final outcome. If all three are scheduled for the first half of the game, the arc is inverted. Restructure so that major escalation, new threats, and decisive moments arrive in the final phase.

What late-game escalation looks like in practice:
- New threat types or mechanics not present earlier
- Resources that become scarcer or more contested late
- Previously stable conditions that become unstable
- Decisions that force tradeoffs between competing goals that were previously compatible (e.g., speed vs. safety vs. party member preservation)

A game that is "effectively decided" before the last third has failed its arc. The final third should feel like the hardest and most consequential part.

### Information Must Be Earned

The player should not have perfect information. Design at least one category of genuinely hidden information that the player can actively discover, infer from evidence, or investigate at cost:

- Opponent capabilities or behavioral patterns revealed through engagement
- Territory contents, environmental hazards, or faction states revealed through scouting
- Item effects, system parameters, or hidden mechanics revealed through experimentation
- Future conditions that can be partially inferred from visible leading indicators

Hidden information must have a **discovery mechanism** — a way the player can learn it if they choose to invest in finding out. Permanently hidden information is arbitrary punishment. Hidden information with a discovery path creates tension, investment, and reward.

Do not display all relevant data on the default screen. Information not immediately needed for the current decision should require the player to actively request it.

**Genuine uncertainty requirement**: At least one important game variable must be *genuinely uncertain* for 5 or more turns — not just hidden-until-investigated, but actively unknowable through any single observation. The player must commit to decisions without knowing it precisely. Good candidates: opponent strategy mode duration, exact formula weights that govern outcomes, a route's hazard composition before scouting, how an NPC will react to a confrontation.

Do not reveal this variable for free in the turn log or status display. Require the player to spend a resource to get an approximation — not the exact value, just a range or indicator. This creates the tension of committing under uncertainty, one of the most powerful engagement drivers.

**Discovery signal validity** (required verification): For every hidden parameter the player can discover through experimentation, verify that your game's structural constraints allow the experiment to actually produce useful data. If a mechanic requires varying an independent variable to observe the effect on an outcome, but a hard cap or guaranteed sell-through prevents that independent variable from ever varying in practice, the discovery system produces no usable signal — every experiment returns the same answer. Before finalizing any discovery mechanic, ask: "Can a player with reasonable resources actually set up the experimental conditions needed to learn this?" If the answer is no, either remove the constraining cap or replace the discovery mechanic with one that generates real information under normal play.

**Management and simulation games are especially prone to the perfect-information failure.** These genres default to displaying every stat on every screen at all times — and this is not good design, it eliminates tension. A management game where exact inventory counts, exact demand rates, exact employee failure probabilities, and exact event likelihoods are all always visible is a spreadsheet. At least two parameters that affect long-run strategy must be hidden by default and discoverable only through active investigation or observation over time: demand elasticity for specific products (requires testing different price points), individual employee failure probability (observable only through enough experience), exact synergy formulas (discoverable through experimentation), or competitor behavior patterns (requires spending a turn to assess). The act of discovering these parameters is itself gameplay — it teaches mastery and rewards investment.

### Failure Is Interesting

When the player fails — loses a battle, goes bankrupt, gets caught — the result should be an interesting new game state, not just "game over, try again." A colony that survives a disaster in a weakened state is more interesting than a reload. A character who escapes capture with nothing is more interesting than a death screen. Design failure states that create new gameplay, not ones that end it.

**Every major failure mode must have at least one non-obvious recovery path.** A reputation death spiral that is unrecoverable after 10% of a run destroys the player experience for 90% of turns. A combat situation that becomes unwinnable by turn 3 of a 30-turn fight makes the remaining turns meaningless. For every significant negative feedback loop, design a counter-pressure: a slower recovery option, a new action available only when desperate, a mechanic that activates when you're losing. Failure should open new gameplay options, not just extend a death march.

### Mastery Must Be Measurable

A game that cannot measure player performance cannot teach mastery. Players improve what they can observe — if there is no feedback on quality of play, there is no skill development, only luck attribution.

**Track performance explicitly.** At minimum: how many turns/actions the player used, what resources were spent or lost, and how the outcome was achieved (the method, not just win/loss). Display this at the end of each major encounter as a grade, rating, or score. Include at least one dimension where skilled play produces a measurably better outcome than average play.

**Make the first challenge teachable.** The opening encounter must be hard enough to require a real decision, but forgiving enough that a player who understands the core mechanic will win. A first encounter with a 95%+ win rate against any strategy teaches nothing.

**Track the player's improvement signal.** If a player does something skilled (executes a setup, exploits a weakness, manages a resource under pressure), acknowledge it with specific feedback: not "you won" but "you won in 8 turns — the par is 14." This tells skilled players their skill mattered.

**Harder challenges must yield proportionally greater rewards.** The game should never reward trivial actions with significant gains — reward magnitude must correlate with difficulty and risk. A player who overcame a difficult encounter should receive more than a player who completed an easy one. If the most rewarding strategy is to repeatedly complete the easiest task, the reward structure is broken.

### The World Acts Without You

A simulation that freezes when the player looks away is not a simulation — it is a stage set. Other actors in the world must pursue their own goals using the same systems the player uses, whether or not the player interacts with them.

**NPC decision cycles run every turn.** Factions accumulate resources, form alliances, make moves, and react to each other according to their own goals and the current game state. The player is one actor in this world, not the protagonist of a theme park.

**NPC goals are specific and traceable.** Every significant NPC or faction has a named objective (control N seats, eliminate rival X, pass policy Y) that shapes their decisions. Players should be able to observe NPC behavior and infer their goals — and then either exploit or counter those goals.

**The world diverges without player input.** If the player takes no action for 3 turns, the game state should change noticeably as a result of other actors' decisions. If it doesn't, the world is a backdrop, not a simulation.

### Overlapping Timelines

The game must always have at least one process in motion whose resolution the player is waiting for, plus at least one unanswered question the player could investigate. When one process resolves, another must already be underway. If the player completes an action and has nothing pending, nothing brewing, and nothing they're curious about, the game has lost momentum.

This is what drives "one more turn" compulsion: the player wants to see what happens next with the thing already in motion, and while waiting they start a new thing they'll want to see through. Design overlapping timelines explicitly — short-term actions that resolve in 1-3 turns, medium-term investments that resolve in 5-10 turns, and long-term campaigns whose outcome is uncertain until the endgame. At any given moment, the player should have stakes at multiple timescales.

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
- **If your game has morale, happiness, or satisfaction, do not model it as a single 0-100 number.** Use at least two interacting dimensions (e.g., safety vs. freedom, material comfort vs. social belonging, individual happiness vs. group cohesion). A single scalar collapses all interesting tension into one optimization target.

**Every spendable resource must have at least one of the following:**
- A hard cap at a strategically meaningful maximum (state the cap in a code comment and justify it: "max food = 20: party of 4 × 5 days of buffer")
- A per-turn decay or maintenance cost
- A diminishing-returns mechanism above a stated threshold

**Hoarding test** (run this before submission): Simulate 20 turns of minimum player activity. Measure each resource's starting and ending value. If any resource exceeds what is strategically useful by more than 20%, add a cap or decay mechanism. Resources that accumulate indefinitely without penalty eliminate timing decisions and break the economy.

### Progression

- **Upgrades must change what the player does, not just modify numbers.** "+5% damage" is not a meaningful upgrade. "Your attacks now pierce armor" or "You can now bribe guards" changes gameplay.
- **Do not gate content behind level/XP grinding.** Gate it behind demonstrated knowledge, acquired tools, or meaningful choices.
- **Lateral progression over vertical progression.** New options that are situationally useful (sidegrades) create richer decisions than universally better replacements (upgrades) that obsolete earlier options.
- **Progression must require player choices, not just time.** Auto-unlocking stats that require no decision are timers, not progression. If a character's skill goes up every 10 turns automatically regardless of what the player does, delete it and put the design energy into a system that requires decisions. For every stat or attribute that changes over time, ask: "Does the player actively choose how this changes?" If no, it is not a game mechanic — it is a passive number that happens to be visible.
- **Progression paths must branch.** If every player who reaches the same point ends up with the same upgrades, there was no meaningful choice. Design upgrade paths where different players make different decisions and end up with genuinely different capabilities.
- **Auto-progression that changes nothing is not progression.** If progression exists (experience, unlocks, upgrades), players must actively choose between distinct paths. All-players-get-the-same-thing-automatically (XP → speed+1, every 10 turns, no choice) is a timer masquerading as a system. The player must face a real fork: upgrade path A vs. path B, where A enables different actions than B. Stat-only improvements that don't change what the player can do are not progression — they are pacing adjustments. Either make the player choose between non-equivalent options, or remove the progression system.

### Information

- **Do not produce walls of text.** Structure output with formatting — headers, indentation, whitespace, clear sections. The player must be able to scan for what matters.
- **Do not show all stats on every screen.** Show what's relevant to the current decision. Other stats should be accessible on request, not omnipresent.
- **Do not make every interaction a numbered menu.** Use contextual commands, free-text input with synonyms, or at minimum, menus that change based on game state. The interface should feel like interacting with a world, not navigating a phone tree.
- **Leave things for the player to discover.** Not every mechanic and interaction needs to be documented up front. Hidden interactions that the player can find through experimentation create moments of delight.
- **Surface what the player is modifying.** If the player takes actions to change a value (trust, morale, sympathy, condition), they must be able to see the current accumulated state of that value — not just deltas. A player who has spent 5 turns building morale and cannot see the current morale level is being asked to manipulate a hidden variable. That is not information design, it is arbitrary opacity. Show current state. Reserve genuine mystery for values the player has not yet chosen to invest in.
- **Never label two different formulas with the same metric name.** If your morning display and evening display both show "Net income," they must compute it identically. Same label, different math, is worse than two different labels — it destroys the player's ability to reason about the game. If you have two legitimately different calculations (e.g., cash flow vs. accounting profit), give them distinct names.
- **Phase gates must have progress indicators.** Every phase transition requirement must be visible to the player as a progress indicator BEFORE the gate triggers. If Phase 2 requires two conditions, both must appear as labeled progress bars or numbers during normal play (e.g., "Phase 2: Rep 38/40, Revenue $4,200/$6,000"). Revealing requirements only in the transition announcement is too late — the player needed that information to pursue the goal.
- **Quantify benefits before asking players to commit.** Every irreversible or costly decision must show the actual numerical effect — not a description — before the player confirms. "This upgrade improves service quality" is not sufficient for a $500 irreversible purchase. "This upgrade increases customer draw by +8% (45% to 53%)" is sufficient. The player must be able to compute the tradeoff.
- **Messages must match implementation timing.** Every message that describes when an effect applies ("visible tomorrow," "takes effect immediately," "activates next turn") must accurately describe when the effect is actually processed in your code. Verify each such message against the implementation. A message that says "tomorrow" when the code applies it today teaches the player a false model of the game.
- **Output length should scale with event importance.** Walking to an adjacent room gets a sentence. Discovering a critical secret gets a paragraph. A routine purchase gets a confirmation line. Winning a climactic battle gets a full scene. Uniform-length output regardless of significance makes everything feel equally unimportant.

### World

- **Do not default to generic fantasy.** Whatever setting you use, give it specific, concrete details that make it THIS world, not a template. If the setting has no distinguishing features, it has no identity.
- **Do not use generic names.** "The Old Tavern," "Mysterious Stranger," "Ancient Sword" — these are the first things an autocomplete would produce. Names should be specific and evocative.
- **The world should operate autonomously.** Events, NPC behaviors, and system dynamics should continue whether or not the player is involved. The player is one actor in a living world, not the center of a theme park.
- **Random events must offer decisions.** "A flood! -20 food" is not gameplay. "A flood threatens the southern fields. Divert workers to build levees (lose production) or evacuate crops (save some, lose the fields)?" is gameplay.
- **Scripted and random events must check the world state they describe.** An event that describes an opponent as desperate must verify the opponent is actually in a desperate state before firing. An event that describes a competitor cutting prices must check that the competitor is in a pricing-aggressive behavioral mode. Events that fire regardless of whether their described state is true produce contradictory information — the player reads one thing in the narrative and sees the opposite in the game state. This destroys world coherence and makes the narrative untrustworthy. For every event in your pool, write the specific world-state predicate it checks before being eligible to fire.
- **Every noun mentioned in a location or scene description must be interactable.** If you describe a glowing console, the player must be able to examine or use it. If you describe a locked door, the player must be able to try to open it. Descriptions that mention objects the player cannot interact with train the player to ignore your descriptions — which means they'll also ignore the interactive objects you do want them to notice.

**If the game has AI opponents, rivals, or NPCs that interact with the player:**
- They must pursue goals using the same systems the player uses — no special AI-only rules or exemptions.
- Their behavior must be **legible**: a player who understands their goals should be able to predict their actions. Opponents should feel like they have strategies, not like they are random number generators.
- They must **react to player actions** — if the player exploits a weakness repeatedly, the opponent adapts. Static opponents who execute the same script regardless of what the player does are not adversaries.
- Different opponents must have **meaningfully different behavioral profiles** — not just different stat values, but different priorities, preferred moves, and vulnerabilities. Fighting opponent A should require different strategy than fighting opponent B.
- Opponent AI quality is a first-class design concern, not an afterthought. Budget significant design time for it.

**Competitors must face the same elimination conditions as the player.** If the player can go bankrupt, be defeated, or lose by resource exhaustion, the competitor must face the same risk. Track the competitor's resource pool every turn. It must decrease from operational costs proportional to their position — competitors that maintain or grow without costs are not simulation participants, they are difficulty modifiers. A competitor that cannot fail is not a competitor. If you find yourself writing AI that only has upside, redesign it to have a real resource pool with real depletion.

**Do not build AI that tracks player patterns without acting on them.** If you write code that records how often the player does X (e.g., `player_action_counts[action] += 1`, `consecutive_attacks`, `known_player_strategy`), you MUST write code that reads this data and changes AI behavior based on it. Otherwise, delete the tracking code entirely — it is false complexity that creates an illusion of adaptation without the substance.

**Every opponent must have at least two behavioral modes** with a concrete, observable trigger condition. Example: "Aggressive until HP below 40%, then defensive." Example: "Pursues resource grab until outmatched in military, then seeks alliance." Modes must be implemented in code and produce visibly different action choices. A single-mode AI executing the same decision function regardless of game state is a script, not an adversary.

**Behavioral mode thresholds must include randomization.** If a mode switches at exactly 40% HP every run, the player learns this after one session and the strategic uncertainty collapses. Each mode transition threshold must vary by at least ±15% between runs or per opponent instance (e.g., `crisis_threshold = 0.40 + random.uniform(-0.08, 0.08)`). State in a code comment what randomizes and the range. The goal: a player who has seen an opponent once cannot precisely predict when it changes modes on the next run.

### Orphaned Mechanics

An orphaned mechanic is code that exists but produces no observable player-facing consequence. It is the most common generator failure mode: the code *describes* a mechanic ("counter window opens," "angle advantage this exchange," "faction morale affected"), but no code path *uses* that description to change outcomes.

**Orphaned mechanics are bugs.** They create false expectations, waste implementation time, and fail audits.

**The implementation-first rule** (critical): Before writing ANY player-facing text that implies a mechanical effect — a phase transition announcement, a menu entry, a tutorial hint, a status message — write the implementing code FIRST. The announcement text is the last thing you write for any feature. Never announce what a feature will do and implement it later. If the code isn't written yet, neither is the announcement.

Before finalizing your game, perform this mandatory mapping:
1. Read every log message, status line, and event description your game produces.
2. For each one that implies a mechanical effect, write down: `"[announcement text]" → Implemented at: function_name():line_N`
3. If you cannot fill in the implementation reference for any announcement, you have two choices: implement it now, or delete the announcement. No third option.
4. Check every variable that accumulates state across turns (counters, history lists, pattern trackers). For each one, find the specific `if` statement or formula that READS this variable and changes game behavior based on it. If no such statement exists, delete the variable — it is false complexity that creates an illusion of depth without the substance.

This audit takes 10 minutes and eliminates the most common failure that produces audit flags.

### Structure

- **Build the gameplay loop before anything else.** No title screens, no settings menus, no character creation wizards. Build the core loop first and verify it's fun. Chrome comes last.
- **Vary the loop.** If every turn/day/cycle follows the exact same structure, the game becomes predictable. Introduce disruptions, phase changes, and escalation.
- **Make options asymmetric.** If factions, classes, or choices exist, they must be mechanically distinct — different strengths, different playstyles, different decisions. Reskinned symmetry is not variety.
- **Test for unwinnable states.** Can the player reach a dead end where progress is impossible but the game doesn't recognize it? If yes, fix it — either prevent the state or detect and handle it.
- **Include negative feedback loops.** If winning begets more winning without limit, the first player to pull ahead wins every time. Include catch-up mechanics or diminishing returns on advantage. **Design and name a specific catch-up mechanism before writing code.** Examples: the AI opponent scales aggression with player success; high-score players face new threats not present at lower scores; leading metrics trigger counter-pressure events; dominant resource positions attract new competitors or costs. A game where sustained success requires no more effort or attention than mediocre performance has no tension in its winning state.
- **Difficulty must change strategy, not just numbers.** If your game offers difficulty settings or scaling, each level must make at least one previously viable strategy non-viable or open at least one strategy not available at other levels. Changing only starting resources or error tolerance — where all difficulty levels produce the same optimal decisions with different margins — creates runs that feel identical with different runway lengths. True difficulty variation forces the player to think differently, not just have more buffer.

### Interface & Usability

- **Do not build the game around numbered menus as the sole interaction mode.** If >80% of player interactions are selecting a number from a static list, the interface has failed. Use contextual commands, abbreviations, state-dependent menus, or free-text input with synonym recognition. The interface should feel like interacting with a world, not navigating a phone tree.
- **Common actions must be fast.** The player's most frequent action should require 1-2 keystrokes. If the player types more than 3 characters for something they do every turn, add a shortcut or alias.
- **Include a help command.** At any point, the player should be able to type `help` (or `?` or `h`) and see what actions are available in the current context. Do not make the player memorize commands — but do not dump all possible commands regardless of context either. Show what's relevant now.
- **Automate sequences that involve no decisions.** If the player must press Enter 5 times to advance through text with no choices between screens, collapse it into one screen. "Press any key to continue" between every screen is not pacing — it is tedium.
- **Communicate the persistence model.** If the game has permadeath, say so. If it auto-saves, say when. If the player can save manually, make the command obvious. An ambiguous persistence model causes anxiety that overrides engagement.

### Visual Representation

- **If the game involves spatial decisions (navigation, positioning, layout, adjacency, line-of-sight), it MUST provide a visual map or grid.** Describing spatial relationships in text alone when a map would work is a design failure. Even a simple ASCII grid communicates spatial information faster and more accurately than paragraphs of directional prose.
- **Use visual gauges for quantities the player monitors.** `[########..] 80%` communicates faster than `HP: 80/100`. Resources, health, progress, morale — any value that changes frequently and matters for decisions should have a compact visual representation alongside or instead of raw numbers.
- **Symbol consistency.** If `#` means wall in one room, it means wall everywhere. If `@` is the player, it is always the player. Do not reuse symbols for different meanings without clear contextual separation (different display modes or labeled sections).
- **ASCII art must communicate information, not just decorate.** A 15-line ASCII title card that pushes game content off the visible screen is anti-design. Every visual element must earn its screen real estate by conveying something the player needs. Decorative borders, elaborate frames, and ornamental dividers that compress actual game information are worse than whitespace.
- **Do not attempt photorealistic ASCII art.** Semi-abstract representations that suggest form (`/\` for a mountain, `~` for water, `T` for a tree) work better than dense character art that resolves into visual noise at terminal scale.

### Code Architecture

- **Define game entities in data structures, not inline in logic.** Items, enemies, abilities, events, and dialogue should live in dictionaries, config tables, or data files — not as if-else chains in the game loop. Adding a new weapon should mean adding a data entry, not editing the combat function.
- **Separate simulation from display.** Do not put `print()` or `input()` inside functions that compute game outcomes. The simulation must be callable without producing output — this makes it testable, verifiable, and auditable. Display functions read game state and present it; simulation functions change game state and return results.
- **Do not put all game logic in one file.** Separate systems into modules (combat, economy, AI, display, game loop). Each module should be understandable without reading the others. A single file with 80%+ of the game logic is unmaintainable and unverifiable.
- **Use named constants for all balance values.** `FLANKING_BONUS = 1.3` is tunable and searchable. `damage *= 1.3` buried in a function is invisible. Every damage number, cost, probability, threshold, and scaling factor should be a named constant defined in one place.
- **Include a debug mode.** The game must have a way to display the current RNG seed, manipulate game state (set resources, skip to phase, spawn specific encounters), and reproduce specific situations. Without this, testing late-game content requires playing through the entire game every time. Gate debug commands behind a flag or command prefix so they don't clutter normal play.
- **Seed your random number generator and log the seed.** Display it at game start or in the debug output. Without reproducible randomness, bugs are unreportable ("it happened once but I can't recreate it"), balance testing is unreliable, and the auditor cannot verify specific claims about game behavior.
