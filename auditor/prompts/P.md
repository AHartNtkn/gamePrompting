# Category P: Interface & Usability

You are evaluating how well the game's interface serves the player. Focus on whether the player can interact with the game efficiently, access the information they need, and recover from mistakes — whether the interface is a transparent window into the game or an obstacle between the player and the experience.

## Criteria and Evaluation Instructions

### P1. Response Immediacy (0-5)

Issue commands and observe the game's response timing. Check:
- Does the game produce output immediately after input, or is there perceptible delay?
- Are there situations where the game pauses, hangs, or produces output in chunks rather than all at once?
- Does the response time remain consistent, or does it degrade in certain game states (large inventories, complex board states, late-game)?

Score 0 if the game has noticeable, frequent delays between input and response — the player waits for the game to catch up, breaking the flow of interaction. Score 2 if response is generally immediate but occasional commands produce perceptible delays. Score 4 if every command produces an immediate response with no perceptible lag under any game state.

### P2. Control Consistency (0-5)

Trace each command across all contexts where it can be used. Check:
- Does the same input always produce the same type of response? (E.g., does "look" always describe the current location, or does it do different things in different modes?)
- Are there contexts where a command's meaning changes without warning?
- Do similar commands follow similar syntax patterns, or is each command its own convention?

Score 0 if commands behave inconsistently — the same input produces different behaviors in different contexts without clear indication, and the player must memorize context-specific command meanings. Score 2 if commands are mostly consistent but a few change behavior in specific contexts. Score 4 if every command behaves predictably in every context — the player can rely on inputs doing what they expect, and any context-dependent behavior is clearly signaled.

### P3. Command Discoverability (0-5)

Start the game as a new player and attempt to determine what actions are available. Check:
- Does the game list or hint at available commands without the player having to guess?
- Is there a help command, command list, or contextual prompt that shows valid inputs?
- Can the player discover the full range of actions through the game's own interface, or must they consult external documentation?
- When new commands become available (new abilities, new contexts), does the game inform the player?

Score 0 if the player must guess commands with no guidance — the game accepts text input but provides no indication of what inputs are valid, requiring trial-and-error or external documentation. Score 2 if a basic help system exists but doesn't cover all commands, or new capabilities are introduced without notification. Score 4 if the player can always determine what actions are available through the game's own interface — commands are listed, contextual options are shown, and new capabilities are announced when they become available.

### P4. Input Efficiency (0-5)

Identify the actions the player performs most frequently, then measure the input required. Check:
- Can common actions be performed with minimal keystrokes? (Single letters, short abbreviations, arrow keys.)
- Are there shortcuts for frequent operations, or must the player type full commands every time?
- Does the input scheme minimize friction for the actions the player does most?
- Are there unnecessary confirmation prompts for routine actions?

Score 0 if common actions require excessive input — the player types long commands for routine operations, with no shortcuts or abbreviations available. Score 2 if basic shortcuts exist but some frequent actions still require more input than necessary. Score 4 if the input scheme is optimized for the most common actions — frequent operations require minimal keystrokes, abbreviations are supported, and the interface never makes the player type more than necessary for routine play.

### P5. Output Density Calibration (0-5)

Read through the game's output during normal play. Check:
- Is each screen of output dense enough to be informative without being overwhelming?
- Does the game dump walls of text that the player must parse for relevant information?
- Or is output so sparse that the player lacks the information they need?
- Is whitespace used effectively to separate logical sections, or is it absent/excessive?

Score 0 if output density is badly miscalibrated — either walls of undifferentiated text that bury important information, or output so sparse that the player cannot determine the game state. Score 2 if output density is generally acceptable but some screens are too dense or too sparse. Score 4 if output density is well-calibrated throughout — every screen presents the right amount of information, clearly organized, with important details easy to find and no wasted space.

### P6. Contextual Help (0-5)

From various game states, attempt to access help. Check:
- Can the player get help relevant to their current situation without leaving the game or resetting their state?
- Does help explain the current context (what commands work here, what the player's options are) or is it a generic manual?
- Is help accessible in every game state, or are there situations where the player is stuck with no way to get guidance?

Score 0 if no help is available, or help requires exiting the current game state. Score 2 if help exists but is generic — a static manual that doesn't adapt to the player's current context or situation. Score 4 if contextual help is available from any game state — the player can always ask for help and receive guidance specific to their current situation, options, and mechanics.

### P7. Turn Structure Clarity (0-5)

Play through the game and observe turn boundaries. Check:
- Is it always clear when the game is waiting for player input?
- Does the player know when their turn begins and ends?
- Is the relationship between player action and game response clear — does the player understand what constitutes a single "move" or action unit?
- Are there situations where the player is unsure whether they should act or wait?

Score 0 if turn structure is opaque — the player frequently cannot tell whether the game is waiting for input, whether their action has been processed, or what constitutes a single turn. Score 2 if turn structure is usually clear but occasionally ambiguous — some sequences leave the player unsure whether to act. Score 4 if turn structure is always unambiguous — the player always knows when to act, what constitutes a complete action, and when the game is processing versus waiting.

### P8. Navigable Interface (0-5)

Navigate through all of the game's menus, screens, and modes. Check:
- Can the player move between different parts of the interface (inventory, map, status, main game) efficiently?
- Are menus logically organized — can the player find what they're looking for without searching?
- Is menu depth reasonable, or must the player navigate through multiple layers to perform simple tasks?
- Can the player return to the main game quickly from any sub-menu?

Score 0 if the interface is disorganized or deeply nested — the player gets lost in menus, cannot find features they know exist, or must navigate excessive layers to perform simple tasks. Score 2 if the interface is functional but some areas are awkwardly organized or require unnecessary navigation steps. Score 4 if the interface is logically organized and efficiently navigable — every feature is where the player expects it, navigation is shallow, and returning to the main game is always quick.

### P9. Memory Burden (0-5)

Play through the game and track what the player must remember. Check:
- Does the game require the player to memorize information that could be displayed? (E.g., remembering which key does what, remembering the map layout when no map is shown, remembering NPC names or quest objectives that are never summarized.)
- Is critical information available for recall, or must the player maintain it mentally?
- Does the game offload memorization to the interface (showing stats, listing known information, providing recaps)?

Score 0 if the game imposes heavy memory burden — the player must memorize maps, stats, quest states, command syntax, and other information that the game could display but doesn't. Score 2 if most critical information is displayed but some must be remembered (e.g., map layout, secondary objectives). Score 4 if the game minimizes memory burden — everything the player needs to know is accessible through the interface, and the player's mental effort goes toward decisions rather than recall.

### P10. Error Recovery (0-5)

Make deliberate input errors and observe the game's response. Check:
- Does the game recognize invalid input and provide a useful error message, or does it crash, ignore the input silently, or produce garbled output?
- Can the player recover from mistaken but valid commands? (E.g., undo, go back, confirmation prompts for irreversible actions.)
- Are there commands with permanent consequences that lack confirmation prompts?
- Does the game distinguish between invalid input (typos, unknown commands) and valid-but-unwise input (attacking an ally, discarding a key item)?

Score 0 if errors are punishing and unrecoverable — invalid input produces crashes or undefined behavior, and mistaken commands have permanent consequences with no confirmation or undo. Score 2 if the game handles invalid input gracefully (error messages, re-prompts) but offers no recovery from valid-but-mistaken commands. Score 4 if the game handles all errors well — invalid input produces helpful messages, dangerous commands require confirmation, and the player can recover from most mistakes.

### P11. Status Visibility (0-5)

At various points during play, determine the player's current state. Check:
- Can the player check their critical status (health, resources, position, objectives, equipment) at any time?
- Is the most important status information visible by default, or must the player request it?
- Are status changes (damage taken, resources gained, stat modifications) reported when they occur?
- Is there a gap between the game's internal state and what the player can observe?

Score 0 if the player has no reliable way to determine their current state — critical information is hidden, and the player must guess their health, resources, or position. Score 2 if status is accessible but requires active querying — the player can check their state but isn't informed of changes as they occur. Score 4 if status visibility is thorough — critical information is always visible or immediately accessible, changes are reported when they happen, and the player is never uncertain about their current state.

### P12. Save/Load Transparency (0-5)

Examine the game's persistence model. Check:
- Does the game clearly communicate how saving works — auto-save, manual save, permadeath, or no persistence?
- Does the player know when their progress has been saved?
- If the game uses permadeath or irreversible decisions, is this communicated before the player encounters it?
- Can the player determine what will be lost if they quit at any point?

Score 0 if the persistence model is opaque — the player cannot determine whether their progress is saved, whether quitting will lose progress, or whether death is permanent until they experience data loss. Score 2 if the persistence model is partially communicated — the player knows saves exist but isn't sure when they occur or what they capture. Score 4 if the persistence model is fully transparent — the player always knows whether their progress is saved, what a save captures, and what the consequences of quitting or dying are.

### P13. Output Proportionality (0-5)

Compare the length and detail of game output across different event types. Check:
- Do trivial, routine actions (moving to a visited location, performing a repeated task) produce brief confirmations?
- Do significant events (discoveries, battles, state changes) receive detailed descriptions?
- Does a revisited location get an abbreviated description while a new significant area gets a full one?
- Or is every output approximately the same length regardless of importance?

Score 0 if all outputs are the same length regardless of significance — walking to an adjacent room produces as much text as discovering a critical secret. Score 2 if some variation exists but it's inconsistent or the ratio is small. Score 4 if output length clearly scales with importance — routine actions are brief, significant events are detailed, and the player can gauge an event's importance from its output length.

### P14. Tedium Automation (0-5)

Check whether the game automates actions that involve no meaningful decision. Check:
- Are there repetitive sequences the player must perform manually despite no choice being involved (walking a known path, restocking from a known source, repeating a solved interaction)?
- Could any of these be handled with a single command or automatically?
- Does the game preserve the player's cognitive load for genuine decisions by eliminating mechanical busywork?

Score 0 if the player must manually perform long sequences of actions where no decision exists — the game requires busywork that could be automated. Score 2 if some automation exists but significant tedious sequences remain. Score 4 if the game identifies and automates or abbreviates every non-decision action sequence — the player's input is reserved exclusively for genuine choices.
