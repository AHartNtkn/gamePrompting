# Category C: World & Simulation

You are evaluating the coherence, richness, and reactivity of the game world as a simulated space. Focus on whether the world behaves as a credible, internally consistent system that responds meaningfully to the player and operates by its own logic.

## Criteria and Evaluation Instructions

### C1. State Richness (0-5)

Inventory the distinct elements in the game world and the states each can occupy. Check:
- How many meaningfully distinct entities exist (locations, characters, resources, objects)?
- Can each entity be in multiple states that affect gameplay differently?
- Do entity states matter — do they influence what actions are available, what outcomes occur, or how other entities behave?
- Or are entities static props with no meaningful state variation?

Score 0 if the world consists of entities with no meaningful state — everything is static and interchangeable. Score 2 if entities have some state variation but many states are cosmetic or rarely affect gameplay. Score 4 if the world contains diverse entities with multiple meaningful states that actively shape the game's dynamics and the player's decisions.

### C2. World Responsiveness (0-5)

Perform significant actions and trace their effects on the broader world. Check:
- Does conquering territory change the political landscape? Does depleting a resource affect the economy? Does helping a faction shift alliances?
- Are the world's responses logical and proportional to the action taken?
- Or does the world absorb player actions like a sponge — nothing changes regardless of what the player does?

Score 0 if the world does not respond to player actions — the game state is effectively static regardless of player input. Score 2 if the world responds to some actions but ignores others of comparable significance, or responses feel disproportionate. Score 4 if the world responds logically and proportionally to player actions across all relevant systems, and the player can observe the ripple effects of their decisions.

### C3. World Memory (0-5)

Take actions in early gameplay and check whether their consequences persist into later gameplay. Check:
- Does the world remember what the player did? Do past decisions continue to affect the present?
- Do NPCs, factions, or systems reflect the player's history?
- Or does the world reset — past actions having no lasting effect?

Score 0 if the world has no memory — previous turns might as well not have happened, with no persistent consequences. Score 2 if some consequences persist but others are forgotten (e.g., resource changes stick but relationship changes reset). Score 4 if the world maintains comprehensive memory of player actions, with early decisions continuing to shape the game world and available options in later gameplay.

### C4. Environmental Variation (0-5)

Survey the game world across its spatial, temporal, or contextual dimensions. Check:
- Do different regions, time periods, or situations present mechanically distinct environments?
- Does the environment vary in ways that affect gameplay — different resources, threats, opportunities, or rules?
- Or is the entire game world mechanically homogeneous, with location/time being purely cosmetic?

Score 0 if the game world is uniform — every location, period, and context is mechanically identical. Score 2 if some variation exists but it is shallow (e.g., different names for the same resources) or confined to a few dimensions. Score 4 if the world varies meaningfully across multiple dimensions, with different areas presenting genuinely different strategic situations, resources, threats, and opportunities.

### C5. Simulation Fidelity Consistency (0-5) `[CONDITIONAL: game models real-world systems]`

Identify the level of detail at which the game models real-world systems, then check for consistency across adjacent systems. Check:
- If the game models agriculture in detail (soil types, irrigation, crop rotation), does it also model weather and economics at comparable fidelity?
- Are there jarring transitions where one system is simulated in depth and an adjacent system is handwaved?
- Does inconsistent fidelity create exploitable gaps or immersion breaks?

Score 0 if fidelity varies wildly — some systems are modeled in granular detail while directly adjacent systems are absurdly simplified, creating an uncanny valley effect. Score 2 if fidelity is mostly consistent but a few systems are noticeably under- or over-detailed relative to their neighbors. Score 4 if the game maintains a consistent level of simulation fidelity across all its systems, with no jarring transitions between detailed and abstract modeling.

### C6. Game State Mutability (0-5)

Track the game state across multiple turns of play. Check:
- Does the game state change meaningfully in response to player actions?
- Are changes substantial (new entities, shifted relationships, altered resource distributions) or trivial (a counter incremented)?
- Can the player reshape the game world, or are they operating within a fixed landscape?

Score 0 if the game state is essentially static — the player's actions have no visible effect on the world's structure. Score 2 if the game state changes but only in limited or superficial ways (e.g., scores change but the world itself is fixed). Score 4 if player actions produce substantial, visible changes to the game world's structure, relationships, and dynamics.

### C7. Rule Symmetry (0-5)

Compare the rules that govern the player to the rules that govern NPCs, enemies, factions, and other entities. Check:
- Do NPCs pay the same resource costs, follow the same movement rules, and face the same combat mechanics as the player?
- Are there abilities or constraints that apply only to the player or only to AI entities?
- Does the player feel like a participant within the world or a privileged outsider exempt from its rules?

Score 0 if the player operates under fundamentally different rules than the rest of the world — the player is clearly a special entity outside the simulation. Score 2 if most rules apply symmetrically but a few notable exceptions exist where the player is treated differently without justification. Score 4 if the player operates under the same rules as every other entity in the world, creating a sense of being a participant within the simulation rather than above it.

### C8. Magic Circle Integrity (0-5)

Evaluate whether the game creates a self-contained space where in-game events carry meaning. Check:
- Do in-game events feel significant within the game's own context?
- Does the game maintain its internal logic consistently enough that the player can take it seriously on its own terms?
- Are there breaks where the game's fiction or systems remind the player they are "just playing a game" in ways that undermine engagement?

Score 0 if the game fails to establish any meaningful internal space — events feel arbitrary and carry no in-game significance. Score 2 if the magic circle holds in some situations but breaks frequently through inconsistencies, immersion-breaking mechanics, or meaningless events. Score 4 if the game creates and maintains a fully coherent internal space where events, actions, and outcomes carry genuine meaning within the game's own terms.

### C9. Internal World Consistency (0-5)

Examine the game world's internal rules — not the game mechanics, but the fiction. Check:
- Does the game world follow its own established logic? If fire burns wood in one context, does it burn wood in all contexts?
- Are there contradictions within the world's own rules (not the player-facing mechanics, but the fiction and simulation)?
- Can the player rely on the world behaving according to its own stated or demonstrated principles?

Score 0 if the game world contradicts its own internal logic regularly — things that should work the same way work differently without explanation. Score 2 if the world is mostly consistent but has a few noticeable contradictions or special cases that break its own rules. Score 4 if the game world follows its own internal logic rigorously and the player can rely on the world behaving consistently according to its established principles.

### C10. World Autonomy (0-5) `[CONDITIONAL: game has off-screen autonomous systems]`

Test whether the game world operates independently of the player's attention and action. Check:
- If the player does nothing for several turns, does the world state change?
- Do events, processes, and agent behaviors continue in areas the player isn't observing?
- Do off-screen factions pursue goals, resources deplete or regenerate, and situations evolve without player involvement?

Score 0 if the world is entirely player-driven — nothing happens unless the player causes it, and the world freezes when the player is inactive. Score 2 if some autonomous processes exist but they are limited or token (e.g., a single timer ticks down, but factions don't act independently). Score 4 if the world actively operates on its own — factions pursue agendas, resources shift, events unfold, and situations evolve regardless of whether the player is watching or acting.

### C11. Simulation Honesty (0-5)

Examine the game's internal logic and compare its stated rules to its actual implementation. Check:
- Are there hidden adjustments — rubber-banding, invisible difficulty scaling, secret probability modifiers, fudged rolls?
- Do the numbers shown to the player match the numbers actually used in calculations?
- If the game says a 70% hit chance, is it actually 70%? Or is there a hidden modifier?
- Can the player trust that the simulation is running the rules as stated?

Score 0 if the game systematically lies about its own rules — hidden modifiers, fudged outcomes, and rubber-banding are pervasive, and the stated rules are not the actual rules. Score 2 if the game is mostly honest but contains a few hidden adjustments (e.g., slight difficulty scaling or occasional probability fudging). Score 4 if the simulation is completely honest — the stated rules are the actual rules, no hidden modifiers exist, and the player can trust every number shown.

### C12. Player-World Ontological Parity (0-5)

Examine whether the player exists as the same type of entity as other beings in the simulation. Check:
- Can the player die to the same hazards that kill NPCs?
- Can the player's structures be damaged or destroyed by the same forces that affect NPC structures?
- Is the player subject to the same environmental effects, status conditions, and systemic consequences as every other entity?
- Or is the player a categorically different type of thing — immune to systems that affect everything else?

Score 0 if the player is ontologically separate from the world — immune to systems that affect other entities, existing as a privileged category outside the simulation. Score 2 if the player is mostly subject to the same systems but has a few notable immunities or special treatments (e.g., the player's buildings can't be destroyed, or the player is immune to certain environmental effects). Score 4 if the player is the same type of entity as everything else in the world — subject to every system, every hazard, and every consequence, with no ontological privilege.

### C13. Player De-Centering (0-5) `[CONDITIONAL: game has a world with independent actors beyond the player]`

Evaluate whether the game world treats the player as the center of everything or as one actor among many. Check:
- Do events happen without the player's involvement? Do factions pursue their own agendas regardless of the player?
- Does the world generate significant events that are not about the player or triggered by the player?
- Is the player one participant in a world that would continue without them, or is the player the axis around which the entire simulation rotates?

Score 0 if the player is the center of the universe — nothing happens without the player's involvement, all events revolve around the player, and the world has no independent existence. Score 2 if some independent activity occurs but most significant events are triggered by or directed at the player. Score 4 if the game world actively generates events, conflicts, and developments independent of the player — the player is one actor among many in a world that operates on its own terms.
