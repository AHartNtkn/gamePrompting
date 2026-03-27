# Category E: Information Design

You are evaluating how effectively the game communicates its state, rules, and consequences to the player. Focus exclusively on information presentation — what the player can see, when they see it, and whether it supports informed decision-making.

## Criteria and Evaluation Instructions

### E1. Data Transparency (0-5)

Identify every variable that influences the player's decisions (health, inventory, enemy stats, turn count, proximity, etc.). For each, check:
- Is it visible on the display, derivable from visible information, or completely hidden?
- If hidden, can the player discover it through a specific action?
- Are there variables that matter for decisions but that the player has no way to access?

Score 0 if most decision-relevant variables are hidden with no way to discover them — the player is making blind guesses. Score 2 if the most important variables are visible but secondary ones require guessing (e.g., the player can see their own HP but not enemy HP or damage ranges). Score 4 if every variable that matters for a decision is either directly displayed or reliably discoverable through a deliberate action.

### E2. State Readability (0-5)

At several points during simulated gameplay, pause and ask: can the player answer "what is happening right now?" from the current display alone? Check:
- Can the player tell whose turn it is, what phase of play they're in, and what just happened?
- Is the spatial layout (if any) parseable without re-reading?
- Are status effects, ongoing conditions, and pending events clearly indicated?

Score 0 if the game state is opaque — the player regularly cannot tell what is happening without replaying previous output. Score 2 if the broad situation is clear but specifics require careful re-reading or remembering prior output. Score 4 if the player can glance at the current output and immediately understand the full situation: positions, statuses, whose turn, what options are available.

### E3. Information Hierarchy (0-5)

Examine how the game arranges information on each output. Check:
- Is the most important information (imminent threats, required decisions, critical resources) the most prominent?
- Is secondary information (flavor text, lore, non-urgent stats) present but subordinate?
- Does the layout make it easy to focus on what matters, or does the player have to hunt for critical data among noise?

Score 0 if all information is presented at the same level of prominence — critical data is buried in walls of equally-weighted text. Score 2 if there is some structure (e.g., status at top, narrative in middle) but important information still competes with less important information for attention. Score 4 if critical information is unmistakably prominent, secondary information is accessible but unobtrusive, and the hierarchy matches the decision-making priority.

### E4. Progressive Disclosure (0-5)

Trace the game from its first output through several turns. Check:
- Does the game introduce mechanics and information gradually as they become relevant?
- Or does the first screen dump every rule, stat, and system on the player at once?
- When new mechanics appear, are they introduced with context, or do they appear without explanation?

Score 0 if the game front-loads all complexity — the player is presented with every system simultaneously from the start and must parse it all to begin. Score 2 if the game starts simply but introduces new systems abruptly or without adequate context. Score 4 if complexity unfolds naturally — new information appears precisely when the player needs it, with enough context to understand it immediately.

### E5. Feedback Specificity (0-5)

For each action the player takes, examine the feedback the game provides. Check:
- Does the feedback explain what happened mechanically (damage dealt, resources spent, state changes)?
- Does it explain why (what modifiers applied, what caused a miss, why an action failed)?
- Does it explain the consequence (what changed as a result, what new state the world is in)?
- Compare vague feedback ("You attack the goblin") vs. specific feedback ("You swing your axe for 8 damage (6 base + 2 flanking). The goblin has 3 HP remaining and is now bleeding.")

Score 0 if feedback is absent or purely cosmetic — actions happen but the game gives no mechanical explanation of results. Score 2 if feedback reports what happened but omits modifiers, reasons, or downstream consequences. Score 4 if every action produces feedback that explains the full causal chain: what happened, what modifiers applied, and what the resulting state is.

### E6. Feedback Timing (0-5)

Trace the temporal relationship between actions and their feedback. Check:
- Does feedback appear immediately after the action that caused it?
- Or is feedback delayed, batched, or separated from the triggering action by intervening output?
- Can the player always connect a feedback message to the action that produced it?

Score 0 if feedback is significantly delayed or disconnected from actions — the player sees consequences but cannot trace them back to their cause. Score 2 if feedback is generally timely but some consequences appear later without clear connection to the originating action. Score 4 if every action's feedback is immediate and unambiguously linked to the action that triggered it.

### E7. Noise-to-Signal Ratio (0-5)

Count the distinct pieces of information the game presents per turn or per screen. Classify each as:
- Signal: information that could change the player's next decision.
- Noise: information that is irrelevant to any decision the player could make.

Check:
- What percentage of displayed information is noise?
- Is there repeated information that adds no value?
- Are there decorative elements that interfere with reading signal?

Score 0 if the display is dominated by noise — most text is irrelevant to decisions and the player must wade through it to find signal. Score 2 if the display is mostly signal but includes non-trivial noise (redundant displays, excessive flavor text, repeated status dumps). Score 4 if virtually every piece of displayed information could influence a decision — the display is lean and purposeful.

### E8. Scan-ability (0-5)

Examine the visual structure of the game's output. Check:
- Can the player quickly locate specific information (e.g., their health, enemy position, available actions)?
- Are important elements visually distinct (through formatting, positioning, separators, labels)?
- Does the layout support rapid scanning, or must the player read linearly from top to bottom every time?

Score 0 if all output is undifferentiated text — the player must read everything linearly to find any specific piece of information. Score 2 if some structure exists (headers, spacing) but key information isn't consistently located or visually distinguishable. Score 4 if the player can instantly locate any needed information because the layout uses consistent positioning, clear labels, and visual structure.

### E9. Information Request Cost (0-5)

Identify every piece of information the player might need during decision-making. For each, check:
- How many actions (keystrokes, commands, menu navigations) does it take to access this information?
- Is commonly-needed information available on the main display, or buried in submenus?
- Must the player leave their current context (interrupting their decision process) to get the information they need?

Score 0 if accessing basic information requires multiple actions, menu navigation, or context switches — the player pays a high cost to get data they need frequently. Score 2 if the most critical information is on the main display but some commonly-needed data requires one or two extra actions to access. Score 4 if everything the player needs for routine decisions is visible without any additional actions, and deeper information is at most one action away.

### E10. Mental Model Alignment (0-5)

Identify how the player naturally thinks about the game (spatially, temporally, categorically). Then check:
- Does the information architecture match that mental model?
- If the game is spatial, is information organized spatially?
- If the game involves categories (types of items, classes of enemies), does the interface group by those categories?
- Does the player ever have to mentally translate from the game's information structure to their own understanding?

Score 0 if the information architecture actively fights the player's mental model — data is organized in a way that makes the player constantly translate (e.g., a spatial game that lists locations alphabetically). Score 2 if the structure is neutral — it doesn't fight the mental model but doesn't strongly support it either. Score 4 if the interface mirrors how the player naturally thinks about the game — information is where you'd expect it, organized the way you'd organize it.

### E11. Error Communication (0-5)

Attempt invalid actions during simulated gameplay. For each, check:
- Does the game tell the player the action is invalid?
- Does it explain why?
- Does it suggest valid alternatives?
- Does it distinguish between "impossible" (you can't do that ever) and "not right now" (you can't do that yet)?

Score 0 if invalid actions are silently ignored or produce a generic "you can't do that" with no further information. Score 2 if the game tells the player the action is invalid and sometimes explains why, but doesn't consistently suggest alternatives. Score 4 if every invalid action produces a specific explanation ("You can't attack — you're out of range. Move 2 spaces closer first.") that tells the player why and what to do instead.

### E12. Hidden Information Purpose (0-5)

Identify every piece of information the game deliberately hides from the player. For each, check:
- Does hiding this information serve a design goal? (Creates tension, enables discovery, simulates fog of war, makes exploration rewarding.)
- Or is it hidden for no discernible reason, leaving the player frustrated without any payoff?
- Does the hidden information create meaningful decisions about whether and how to uncover it?

Score 0 if information is hidden arbitrarily — the player is denied data they need to make decisions and the concealment serves no identifiable gameplay purpose. Score 2 if most hidden information serves a purpose but some important data is inexplicably withheld. Score 4 if every piece of hidden information has a clear design rationale, and the act of uncovering hidden information is itself a meaningful part of gameplay.

### E13. Discoverable Information (0-5)

For each piece of hidden information identified in E12, check:
- Is there a gameplay mechanism for discovering it? (Scouting, investigating, experimenting, using items.)
- Can the player choose to invest effort in uncovering hidden information?
- Is the discovery process itself interesting and interactive, or is it rote?

Score 0 if hidden information cannot be uncovered — it is permanently unknown and the player must always guess. Score 2 if hidden information can be discovered but the mechanisms are limited or uninteresting (e.g., "examine" always reveals everything). Score 4 if discovery is a rich part of gameplay — multiple methods exist, they have different costs and reliability, and uncovering information is a satisfying activity in its own right.

### E14. Information Advantage Fairness (0-5)

Examine whether skilled play yields better information. Check:
- Does a player who plays well (explores more, pays attention, makes good choices) end up with more and better information than one who plays poorly?
- Or does information distribution have no correlation with player skill?
- Can information acquisition be a reward for good play?

Score 0 if information access is entirely arbitrary — equally available regardless of how well the player plays. Score 2 if some information is earned through play but the correlation between skill and information advantage is weak. Score 4 if skilled play systematically yields better information, and this information advantage is itself a reward and a tool for further success.

### E15. Fog of War Coherence (0-5) `[CONDITIONAL: game has fog of war / spatial unknown]`

Examine the boundary between known and unknown areas. Check:
- Does the fog of war follow consistent, logical rules? (E.g., line of sight, exploration radius.)
- Are there anomalies where the player can see things they shouldn't, or can't see things they should?
- Does the fog update correctly as the player moves and the world changes?
- Does the information boundary make spatial and logical sense?

Score 0 if the fog of war is inconsistent — the player can see some things they shouldn't and can't see things they should, with no discernible logic. Score 2 if the fog mostly follows logical rules but has edge cases where visibility doesn't match expectations. Score 4 if the fog of war is fully coherent — every boundary follows from clear rules the player can learn, and it updates correctly in all situations.

### E16. Numbers Visibility (0-5)

Identify the numerical values underlying the game's systems (damage values, hit chances, resource costs, stat modifiers). Check:
- Can the player see these numbers when they want to reason quantitatively about a decision?
- Are exact values shown, or only vague qualitative indicators ("strong," "weak")?
- Can the player access the formulas or at least the inputs and outputs?

Score 0 if numerical values are completely hidden — the player cannot access any quantitative data and must guess at all values. Score 2 if some numbers are visible (e.g., HP, basic stats) but important derived values (damage calculations, hit chances) are hidden. Score 4 if the player can access every number they need to reason quantitatively — exact values, modifiers, and ideally the formulas that combine them.

### E17. Environmental Legibility (0-5)

Examine whether the game world itself communicates information, as opposed to requiring UI overlays or status screens. Check:
- Do descriptions of the environment convey gameplay-relevant information? (E.g., "The passage narrows and the air grows cold" signaling danger, vs. a status line that reads "Danger: High.")
- Can the player learn about threats, opportunities, and navigation from the world's own properties?
- Or must the player rely entirely on meta-UI (status bars, minimaps, indicators) to understand their situation?

Score 0 if the game world is informationally inert — all gameplay information comes from UI overlays and the environment description is purely decorative. Score 2 if the environment occasionally conveys information but the player must primarily rely on status screens and explicit indicators. Score 4 if the environment is rich with information — descriptions, behaviors, and environmental cues communicate threats, opportunities, and world state, reducing dependence on meta-UI.