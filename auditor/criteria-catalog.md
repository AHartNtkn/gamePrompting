# Game Design Criteria Catalog

Comprehensive, unfiltered catalog of evaluable game design criteria. Deduplicated across sources but not pre-filtered for relevance. Source frameworks noted in parentheses. Each criterion is stated as an evaluable question.

**Conditional criteria** are marked with `[CONDITIONAL]`. These only apply if the game has the relevant feature. When a criterion doesn't apply, it scores **N/A (0/0)**, not 0/5. Aggregation uses sum of earned points / sum of applicable points.

---

## A. Rules & Formal Structure

How well-designed are the game's foundational rules?

**A1. Rule Clarity**
Are the base rules unambiguous and learnable? Can a new player determine what is and isn't legal without guessing?
*(MDA, Salen/Zimmerman — operational rules)*

**A2. Rule Consistency**
Do rules apply uniformly across all situations? Does "if X then Y" always hold, or are there silent exceptions?
*(Salen/Zimmerman, PLAY — consistent world)*

**A3. Mechanic Orthogonality**
Does each mechanic serve a distinct purpose? Are there redundant systems that do roughly the same thing?
*(MDA — mechanics level)*

**A4. Action Space Adequacy**
Does the set of available player actions cover the space the game intends to simulate? Are there obvious actions the player should be able to take but can't?
*(MDA — mechanics level)*

**A5. Core Clarity**
Does the game have a clear central mechanic that everything else orbits? Or is it a scattered collection of systems with no center of gravity?
*(Burgun — clockwork game design)*

**A6. Core Support**
Does every additional mechanic reinforce the core, or do some pull the experience in unrelated directions?
*(Burgun — clockwork game design)*

**A7. Noise Elimination**
Does every rule earn its place? Are there rules that could be removed without reducing the game's depth?
*(Burgun — clockwork game design)*

**A8. Constitutive Rules Quality**
Are the underlying formal rules (math, algorithms, probability distributions) well-designed? Do the numbers work?
*(Salen/Zimmerman)*

**A9. Mechanic-Aesthetic Alignment**
Do the mechanics actually produce the experience the game appears to be going for? Or do the systems generate dynamics at odds with the apparent intent? If you stripped all flavor text and renamed every element generically, would the game still communicate what it's "about" through its systems alone?
*(MDA — cross-layer coherence; Johnson "theme is not meaning" — meaning comes from mechanics, not setting)*

**A10. Lusory Attitude Reward**
Does the game reward players who engage with it in the spirit of play? Or does engaging earnestly put you at a disadvantage compared to exploiting the rules?
*(Salen/Zimmerman)*

---

## B. Systems & Emergence

Do the game's systems interact to produce non-obvious outcomes?

**B1. System Interaction Density**
How many of the game's mechanics influence each other? Are systems interconnected or isolated?
*(Emergent narrative research, MDA — dynamics)*

**B2. Emergent Behavior**
Do combinations of rules produce outcomes that are non-obvious but logically follow from the rules?
*(MDA, Salen/Zimmerman, Koster)*

**B3. Dynamic Variety**
Do different player inputs produce observably different runtime behaviors? Or does the game funnel toward the same dynamics regardless?
*(MDA — dynamics)*

**B4. Feedback Loop Health**
Are positive and negative feedback loops present and intentional? Do they serve the game's goals (stabilizing when needed, destabilizing when needed)?
*(MDA — dynamics)*

**B5. Chain Reaction Potential**
Can events cascade through multiple systems? (E.g., drought → food shortage → unrest → rebellion → neighboring faction attacks)
*(Emergent narrative research)*

**B6. Unpredictability from Determinism**
Do surprising outcomes arise from deterministic rule interactions rather than from random number generators?
*(Emergent narrative research)*

**B7. World Coherence Under Stress**
Does the simulation remain internally consistent when pushed to extremes? Or do edge cases produce absurd results?
*(Emergent narrative research)*

**B8. Depth-to-Complexity Ratio**
How many meaningful decisions emerge per unit of rule complexity? High ratio = elegant. Low ratio = bloated.
*(Strategy game research, Burgun)*

**B9. Compositional Mechanics**
Can the game's mechanics be combined by the player to produce effects that logically follow from each mechanic's rules but weren't explicitly designed? Does the game provide tools that compose (like a grammar of verbs and nouns) rather than prescribing fixed solutions?
*(Player experience gap — distinct from B2 Emergent Behavior, which is a system property; compositionality is player-accessible combinatorics. BotW Chemistry Engine, Nethack item interactions)*

**B10. Systemic Predictability**
Can the player predict the outcome of novel system interactions by reasoning from established rules? When two systems interact in a situation the player hasn't seen, can they correctly guess what happens based on how each system works individually?
*(Player experience gap — distinct from A2 Rule Consistency (rules don't contradict) and C9 (world is believable); this asks whether rules compose predictably for novel situations)*

**B11. Structural Emergence**
Do the game's macro-level patterns — phases, difficulty progression, pacing arcs — arise from its systems, or are they imposed by special-case logic? In a well-designed simulation, early/mid/late game feel different because the systems naturally reach different equilibria (resource depletion shifts priorities, capability accumulation opens new strategies, environmental pressure changes the viable action space), not because scripted triggers change the rules at predetermined points. If removing all phase/difficulty scripting would cause the game to feel undifferentiated, the systems aren't doing their job.
*(Player experience gap — Project Zomboid, Dwarf Fortress, RimWorld: phases emerge from systems reaching different equilibria, never from scripted triggers. Distinct from J7 Arc Structure which asks whether phases exist; this asks whether they're earned by the simulation or imposed on it)*

**B12. Simulation Perceptibility**
Does every simulated system produce player-observable effects? Can the player detect each system's existence and infer its behavior through normal play, without documentation? A system that operates but whose effects are invisible to the player is wasted computation — it contributes nothing to the player's mental model and might as well not exist.
*(Sylvester "Player Model Principle" — anything in the Game Model that doesn't copy into the Player Model is worthless. Distinct from E1 Data Transparency (can you see state) and S2 Decorative Systems (stats with no mechanical effect) — a system can have mechanical effect and still be imperceptible to the player)*

**B13. Narrative Prompt Density** `[CONDITIONAL: game has enough systemic breadth for narrative emergence]`
Does the simulation produce events that are specific enough to be meaningful but ambiguous enough to invite player interpretation? Does the game leave narrative gaps for the player to fill, rather than over-specifying every event's meaning? The simulation doesn't need to produce complete stories — it needs to produce sequences that the player's mind completes through apophenia.
*(Sylvester apophenia, Adams collaboration with player imagination, Wright "player imagines the simulation is better." Distinct from K10/K11 Narrative Emergence which ask whether story-worthy events occur — this asks whether the game calibrates specificity vs. ambiguity to leverage the player's imagination)*

**B14. Entity Narrative Specificity** `[CONDITIONAL: game has individually simulated entities]`
Are emergent events specific to the particular entities involved — their histories, properties, relationships — or are they generic events that could have happened to any interchangeable entity? "A colonist died" is a system event. "Urist, who hated rain and loved plump helmets, died of thirst because she refused to cross an outdoor bridge during a drizzle" is a story.
*(Adams narrative specificity, Paradox character-driven design, Solomon permadeath attachment. Distinct from K10 which asks whether events are story-worthy — this asks whether they're specific to the entities involved)*

---

## C. World & Simulation

How coherent, rich, and reactive is the game world?

**C1. State Richness**
Does the world contain meaningfully distinct elements that can be in different states? Do those states actually matter to gameplay?
*(Original auditor)*

**C2. World Responsiveness**
Does the world react to player actions in ways that feel logical and proportional? Does conquering territory change the political landscape? Does depleting a resource affect the economy?
*(Original auditor)*

**C3. World Memory**
Does the world remember what the player has done? Do past actions have persistent consequences, or does the world reset?
*(Anti-pattern: World Amnesia)*

**C4. Environmental Variation**
Does the game world vary across space, time, or context? Or is it uniform throughout?
*(Anti-pattern: Flat World)*

**C5. Simulation Fidelity Consistency** `[CONDITIONAL: game models real-world systems]`
If the game simulates reality at a certain fidelity, does it maintain that fidelity consistently? Or does it model some things in detail and handwave adjacent things, creating jarring inconsistencies?
*(Anti-pattern: Uncanny Valley of Simulation)*

**C6. Game State Mutability**
Does the game state change meaningfully in response to player actions? Or is it largely static?
*(Costikyan)*

**C7. Rule Symmetry**
Does the player operate under the same rules as the rest of the world? Are NPCs, enemies, and factions subject to the same systems the player is (resource costs, movement rules, combat mechanics, environmental effects)? When this holds, the player feels like a participant *in* the world rather than something separate from it. Even the impression of symmetry (as in Dark Souls, where it *feels* like enemies follow the same rules) creates a greater sense of accomplishment and immersion.
*(Player experience gap — not present in standard design frameworks; widely cited by players of sim games, roguelikes, and immersive sims)*

**C8. Magic Circle Integrity**
Does the game successfully create a bounded, internally-meaningful space where in-game events matter on their own terms?
*(Salen/Zimmerman)*

**C9. Internal World Consistency**
Is the game world believable on its own terms? Do the rules of the fictional world hold consistently?
*(Schell — Lens #74)*

**C10. World Autonomy** `[CONDITIONAL: game has off-screen autonomous systems]`
Does the game world operate independently of the player's attention? Do events, processes, and agent behaviors continue in areas/systems the player isn't observing? If the player does nothing for several turns, does the world state change?
*(Player experience gap — Harvey Smith on systemic design; widely cited in Dwarf Fortress, Rimworld, Kenshi praise)*

**C11. Simulation Honesty**
Does the game produce outcomes strictly from its stated rules? Are there hidden adjustments — rubber-banding, invisible difficulty scaling, secret probability modifiers, fudged rolls? Can the player trust that the numbers shown are the numbers used? Does the game world follow its rules uniformly regardless of player state — the world is indifferent, not accommodating?
*(Player experience gap — distinct from E1 Data Transparency (can you see the state) and Q3 AI Fairness (does AI cheat); this asks whether the game's stated rules are its actual rules. Spelunky: "the world is indifferent" — rules apply uniformly regardless of whether the player is a novice or expert)*

**C12. Player-World Ontological Parity**
Is the player an entity *within* the simulation, subject to the same ontological category as other entities? Can the player die to the same hazards as NPCs, have structures damaged the same way? Or is the player a privileged outsider the simulation treats as a special case?
*(Player experience gap — extends C7 Rule Symmetry from rule parity to entity-type parity; Kenshi, DF adventure mode, CDDA)*

**C13. Player De-Centering** `[CONDITIONAL: game has a world with independent actors beyond the player]`
Does the game avoid making the player the center of the universe? Do events happen without the player's involvement? Do factions pursue their own agendas regardless? Is the player one actor among many, not the axis around which the world rotates?
*(Player experience gap — opposes L3 Player-as-Star; captures what simulation-focused players mean by "the world doesn't care about you" as praise)*

**C14. Subordinate Agent Autonomy** `[CONDITIONAL: game has entities the player directs]`
Do entities under the player's nominal control exercise independent judgment, priorities, or resistance? Does the player give orders to agents who interpret those orders through their own capabilities, moods, and priorities rather than executing them mechanically? Does this autonomy create interesting tension rather than pure frustration?
*(Adams "dwarves exercise autonomy outside official duties," Paradox "AI isn't here to win, it's here to roleplay," management game delegation research. Distinct from C10 World Autonomy (world moves without player) and Q2 AI Personality (AI entities behave distinctly) — this is specifically about the player's OWN subordinates having agency)*

---

## D. Decision Architecture

Does the game present the player with meaningful, well-constructed choices?

**D1. Decision-Making Centrality**
Is the core activity of the game making decisions? Or is the player mostly watching, reacting to reflex prompts, or grinding?
*(Costikyan, Sid Meier)*

**D2. Decision Meaningfulness**
Do choices produce distinct, consequential outcomes? A choice between equivalent options is not a decision.
*(Schell — Lens #32, Salen/Zimmerman — meaningful play)*

**D3. Decision Frequency**
How often does the player face a genuinely interesting decision? Is the interesting-decision-per-minute rate high or low?
*(Sid Meier, Burgun)*

**D4. Decision Ambiguity**
Are decisions genuinely ambiguous — no clearly correct answer? Or can the player solve them with basic math?
*(Burgun — decision quality)*

**D5. Trade-off Clarity**
Can the player understand what they are giving up when they choose? Are the costs and benefits of each option legible?
*(Original auditor, economy design research)*

**D6. Triangularity**
Do choices involve risk/reward trade-offs that create tension? (Safe option with low payoff vs. risky option with high payoff)
*(Schell — Lens #33)*

**D7. Expected Value Reasoning**
Can the player reason about the expected value of their choices? Is enough information available for informed gambling?
*(Schell — Lens #28)*

**D8. Strategic Depth**
Are there multiple viable long-term approaches? Does the game support different playstyles that are all competitive?
*(Original auditor, strategy game research)*

**D9. Tactical Granularity**
Do moment-to-moment choices matter? Or does the game only care about big-picture decisions, with individual turns blurring together?
*(Original auditor)*

**D10. Choice Reversibility**
Are choices permanent when they should be (creating stakes) and reversible when that serves gameplay (allowing experimentation)?
*(Player agency research)*

**D11. Choice Awareness**
Does the player know they are making a choice? Are decision points clearly signaled, or do consequential choices happen invisibly?
*(Player agency research)*

**D12. Consequence Visibility**
Can the player see the results of their choices? Is the causal chain from decision to outcome traceable?
*(Player agency research, Salen/Zimmerman — discernible meaningful play)*

**D13. Consequence Delay**
Is the time between choice and consequence appropriate? Immediate for tactical decisions, delayed for strategic ones?
*(Player agency research)*

**D14. Consequence Integration**
Do the outcomes of player actions feed into the larger game context? Or are they locally resolved and forgotten?
*(Salen/Zimmerman — integrated meaningful play)*

**D15. Multi-Dimensional Strategy** `[CONDITIONAL: game has multiple orthogonal management domains]`
Must the player simultaneously manage multiple orthogonal concerns (military, economic, diplomatic, internal)?
*(Grand strategy research)*

**D16. Plan Fragility**
Can plans be disrupted by unforeseen events, requiring adaptation? Or can the player set a plan and execute it without interference?
*(Grand strategy research)*

**D17. Consequence Irreversibility Spectrum**
Does the game provide a graduated range of consequence permanence? Some decisions easily reversible (allowing experimentation), some costly to reverse (creating stakes), some permanent (creating weight)? Is this spectrum intentional and well-distributed across the game?
*(Player experience gap — D10 evaluates individual choices; this evaluates the distribution of permanence across the game)*

**D18. Routine Activity Interest**
Are the game's most frequently performed activities — the ones comprising the majority of playtime — mechanically engaging in themselves? Or is the player grinding through routine to reach occasional interesting decisions? Every activity the player repeats many times should involve a genuine choice.
*(Zomboid mundane tasks as core gameplay, DCSS "no tedium," Cogmind automate obvious choices, Factorio real-world problem analogs. Distinct from D1 Decision-Making Centrality and J2 Dead Time Absence — this asks whether high-frequency routine actions are themselves interesting)*

**D19. Mundane-to-Critical Cascade Potential**
Can routine, low-stakes actions trigger chains of consequences that escalate to critical situations? Is there genuine tension in everyday decisions because of their catastrophic potential? In well-designed simulations, routine foraging can lead to a zombie horde encounter; a minor diplomatic insult can cascade into war.
*(Zomboid, Spelunky, Adams "can a story thread pass through this feature?" Distinct from B5 Chain Reaction Potential which frames cascades in terms of dramatic events — this asks whether MUNDANE actions have cascade potential)*

---

## E. Information Design

Can the player understand what's happening and why?

**E1. Data Transparency**
Can the player observe or infer the relevant game state? Are important variables visible or discoverable?
*(MDA — mechanics level)*

**E2. State Readability**
Can the player parse the current game state without confusion? Can they answer "what is happening right now?" quickly?
*(Information design research, original auditor)*

**E3. Information Hierarchy**
Is critical information prominent and secondary information accessible but non-intrusive? Does the display prioritize what matters?
*(Information design research)*

**E4. Progressive Disclosure**
Is complexity revealed gradually as the player needs it? Or is the player hit with everything at once?
*(Information design research)*

**E5. Feedback Specificity**
Does feedback explain what happened, why, and what it means? "You attacked" is vague. "You struck for 12 damage, flanking bonus, goblin staggers" is specific.
*(Information design research, original auditor)*

**E6. Feedback Timing**
Is feedback immediate enough to connect action to consequence? Or is there a confusing delay?
*(Information design research, Flow theory, GameFlow)*

**E7. Noise-to-Signal Ratio**
How much irrelevant information does the player receive relative to relevant? Is the display cluttered with data that doesn't inform decisions?
*(Information design research)*

**E8. Scan-ability**
Can the player quickly scan the display for key information? Are important elements visually distinct?
*(Information design research)*

**E9. Information Request Cost**
How many actions does it take to access needed information? Must the player navigate menus to find basic data?
*(Information design research)*

**E10. Mental Model Alignment**
Does the interface match how the player thinks about the game? Or does the information architecture fight the player's natural mental model?
*(Information design research)*

**E11. Error Communication**
When the player makes an invalid action, does the game explain why and what valid alternatives exist?
*(Information design research, PLAY heuristics)*

**E12. Hidden Information Purpose**
Does hidden information serve a design goal (tension, discovery, fog of war)? Or is it hidden for no reason, just frustrating the player?
*(Information asymmetry research)*

**E13. Discoverable Information**
Can hidden information be uncovered through gameplay? Is there a mechanism to learn what's hidden?
*(Information asymmetry research)*

**E14. Information Advantage Fairness**
Does information discovery correlate with skilled play? Does better play yield better information?
*(Information asymmetry research)*

**E15. Fog of War Coherence** `[CONDITIONAL: game has fog of war / spatial unknown]`
Is the boundary between known and unknown logically consistent? Does the information model make spatial/logical sense?
*(Information asymmetry research)*

**E16. Numbers Visibility**
Are underlying numerical values visible when the player wants them? Can the player "see the math" when they need to reason about outcomes?
*(Berlin interpretation, roguelike design)*

**E17. Environmental Legibility**
Can the player understand the world's state, dangers, and opportunities by observing the environment itself, without relying on UI overlays, status screens, or explicit annotations? Does the game world communicate information through its own properties (descriptions, behavior, environmental cues) rather than through meta-UI?
*(Player experience gap — E1-E16 evaluate whether info is available and well-presented; this evaluates whether it's communicated diegetically or through overlay. In CLI games: does the text describe gameplay-relevant info, or must the player check separate status screens?)*

---

## F. Uncertainty & Randomness

How does the game create and manage uncertainty?

**F1. Performative Uncertainty**
Does the game test whether the player can execute their intentions? Is there skill involved in carrying out a plan?
*(Costikyan — Uncertainty in Games)*

**F2. Solver's Uncertainty**
Does the game present problems the player must figure out how to solve?
*(Costikyan — Uncertainty in Games)*

**F3. Player/AI Unpredictability**
Do other agents (AI or human) behave in ways that can't be fully predicted? Does the player have to model other agents' decision-making?
*(Costikyan — Uncertainty in Games)*

**F4. Randomness as Situation Generator**
Is randomness used to create interesting situations rather than to arbitrarily determine outcomes? Does the dice roll create a problem to solve, or does it just decide success/failure?
*(Schell — Lens #29, Costikyan)*

**F5. Analytic Complexity**
Is the decision space complex enough that the player can't fully calculate optimal moves? Must they rely on judgment and heuristic reasoning?
*(Costikyan — Uncertainty in Games)*

**F6. Perception Uncertainty**
Is the player ever uncertain about whether they are perceiving the game state correctly? Does the game play with perception (fog, deception, incomplete info)?
*(Costikyan — Uncertainty in Games)*

**F7. Uncertainty Calibration**
Is total uncertainty sufficient to maintain interest but not so high as to feel arbitrary? Is the player uncertain about what matters without feeling powerless?
*(Costikyan — Uncertainty in Games)*

**F8. Uncertainty Source Diversity**
Does the game draw from multiple types of uncertainty? Or is it one-dimensional (e.g., all randomness, no analytic complexity)?
*(Costikyan — Uncertainty in Games)*

**F9. Outcome Uncertainty**
Is the game's outcome genuinely uncertain until late in the experience? Or is the result foreseeable early on?
*(Salen/Zimmerman)*

**F10. Skill vs. Chance Balance**
Is the ratio of skill-based outcomes to luck-based outcomes appropriate for the game's goals?
*(Schell — Lens #34)*

**F11. Agency-Randomness Balance**
Does the player feel their choices matter more than luck? Even with randomness present, does skill determine long-run outcomes?
*(Player agency research)*

**F12. Pre-Action vs. Post-Action Randomness**
Is randomness primarily front-loaded (the player is dealt a random situation and must decide how to respond) or back-loaded (the player chooses an action and randomness determines if it succeeds)? Front-loaded randomness creates decision-rich situations with clear agency; back-loaded randomness creates slot-machine feel.
*(Roguelike practitioner consensus, Spelunky, Cogmind. Distinct from F4 and F11 — this asks WHEN randomness resolves relative to the player's decision point)*

---

## G. Economy & Resource Design `[CONDITIONAL: game has economy/resources]`

Are the game's resources well-designed?

**G1. Resource Management Centrality**
Does the player manage scarce resources toward their goals? Are resource decisions a meaningful part of gameplay?
*(Costikyan, Berlin interpretation)*

**G2. Faucet-Sink Balance**
Is the rate of resource creation balanced by resource consumption? Is there a steady state, or does accumulation trivialize scarcity?
*(Economy design research)*

**G3. Inflation Resistance**
Does the economy avoid runaway resource accumulation? Are late-game resources still meaningful or are they trivially abundant?
*(Economy design research)*

**G4. Pinch Point Design**
Are there moments where resources become meaningfully scarce? Does the player ever face genuine resource pressure?
*(Economy design research)*

**G5. Currency Differentiation**
Do different resources serve different purposes? Are they functionally distinct, or are they effectively interchangeable?
*(Economy design research)*

**G6. Resource Trade-off Clarity**
Can the player reason about the cost of resource allocation decisions? Is the opportunity cost of spending resource A on goal X (instead of goal Y) legible?
*(Economy design research)*

**G7. Endogenous Value**
Do game objects have value that is meaningful within the game's internal logic? Does the player care about in-game currency/items because the game makes them matter?
*(Schell — Lens #7)*

**G8. Economic Dynamism**
Does the economy change over time? Do prices, scarcity, and availability shift based on player and world actions?
*(Economy design research)*

**G9. Attention as Resource** `[CONDITIONAL: game has multiple simultaneous management domains]`
Does the game treat the player's attention as a binding constraint? Are there more systems demanding oversight than the player can simultaneously manage, forcing prioritization of focus? Does neglecting a system produce consequences?
*(Johnson Old World's Orders system, Paradox multi-front management, management game research. Distinct from D15 and G1 — this identifies the player's own attention as the binding constraint)*

---

## H. Challenge & Difficulty

Is the game's challenge well-calibrated?

**H1. Challenge Appropriateness**
Is the game appropriately challenging — neither trivially easy nor impossibly hard for its target audience?
*(Schell — Lens #31, GameFlow, GEQ)*

**H2. Skill-Challenge Balance**
Is the challenge calibrated to the player's current skill level? Does the game operate in the flow channel between boredom and anxiety?
*(Csikszentmihalyi, Schell — Lens #21, GameFlow)*

**H3. Challenge Variety**
Does the game provide multiple types of challenges? Or is every obstacle the same kind of problem?
*(GameFlow, PLAY heuristics)*

**H4. Difficulty Escalation**
Does difficulty increase at an appropriate rate as the player improves? Is early game simpler than late game?
*(GameFlow, original auditor)*

**H5. Opposition Quality**
Is there meaningful resistance to the player's objectives? Do obstacles feel real and worth overcoming?
*(Costikyan — opposition/struggle)*

**H6. Fairness**
Does the game feel fair? Does the player believe their outcomes are deserved — that success came from good play and failure from bad play?
*(Schell — Lens #30, PLAY heuristics)*

**H7. Consequence Proportionality**
Are punishments proportional to mistakes? Can a small error cause catastrophic loss, or are setbacks scaled to the error's severity?
*(Harris — No Beheading, error recovery research)*

**H8. Failure Informativeness**
When the player fails, do they understand why? Does failure teach them something they can apply next time?
*(Anti-pattern: Punishment Without Learning)*

**H9. Head vs. Hands Balance**
Is the ratio of mental challenge to execution challenge appropriate for the game's goals? (For CLI games, this is mostly mental, which should be intentional.)
*(Schell — Lens #35)*

**H10. Dynamic Difficulty**
Does the difficulty adapt (explicitly or through player-chosen paths) as skill grows? Can players self-select challenge level through their choices?
*(Flow theory)*

**H11. No Instant Death**
Is the player protected from instant-kill outcomes during reasonable play? Are lethal situations telegraphed?
*(Harris — No Beheading, No Cyanide)*

**H12. Failure Generativity**
When the player fails, does the failure produce an interesting new game state rather than simply ending or resetting? Can the player lose a battle but continue the war? Do failed states generate their own emergent gameplay? ("Losing is Fun" — Dwarf Fortress)
*(Player experience gap — H8 asks if failure is informative; L5 asks if it's recoverable; this asks whether failure creates new, playable situations)*

**H13. Anti-Stall Pressure**
Does the game have a mechanism that prevents the player from stalling indefinitely at a comfortable difficulty level? Is there an inherent cost to inaction or excessive caution — resource drain, escalating threats, timer, corruption, or other pressure that forces forward into risk?
*(Harris Anti-Grind Rule and Race You Can't Win Rule, DCSS food clock, ADOM corruption, Spelunky ghost timer. Distinct from O7 and H4 — this asks whether there is a mechanism that punishes STALLING)*

**H14. Death Informativeness** `[CONDITIONAL: game has permadeath or significant failure states]`
When the player dies or suffers a major failure, does the game present enough information for them to understand what killed them and how to avoid it next time? Is the death screen / post-mortem itself a learning tool?
*(Roguelike practitioner consensus, DCSS philosophy. Distinct from H8 Failure Informativeness — this is specifically about POST-MORTEM information presentation in high-stakes games)*

---

## I. Learning & Mastery

Does the game reward investment in understanding its systems?

**I1. Pattern Richness**
Does the game contain learnable patterns at multiple levels of complexity? Can the player always go deeper?
*(Koster — Theory of Fun)*

**I2. Learning Curve Continuity**
Is there always something new to learn? Or does learning plateau, leaving the player doing the same thing with no growth?
*(Koster — Theory of Fun)*

**I3. Mastery Depth**
How deep can mastery go? Is there always a higher level of play to achieve? Can a beginner and an expert play the same game with very different effectiveness?
*(Koster — Theory of Fun)*

**I4. Grokking Resistance**
How long before the player fully internalizes all patterns? If the game is "solved" quickly, it has low grokking resistance.
*(Koster — Theory of Fun)*

**I5. Pattern Visibility**
Can the player perceive the patterns they are learning? Or are the underlying dynamics opaque, making improvement feel random?
*(Koster — Theory of Fun)*

**I6. Skill-Expression Space**
Once patterns are learned, can the player express mastery in varied ways? Or is there only one way to play well?
*(Koster — Theory of Fun)*

**I7. Degenerate Pattern Absence**
Are there patterns that, once learned, trivialize the game? (A degenerate pattern is a strategy so dominant that learning it ends meaningful play.)
*(Koster — Theory of Fun)*

**I8. Skills Developed Through Play**
Are skills developed organically through gameplay rather than through explicit instruction or memorization?
*(GameFlow — player skills)*

**I9. Skilled Play Rewarded**
Does the game measurably reward skilled play? Can a good player see evidence that their skill matters?
*(GameFlow — player skills)*

**I10. Skill Ceiling Visibility**
Can the player perceive that there is a higher level of mastery to achieve? Do they know they can get better?
*(Game Feel — Swink)*

**I11. Competence Growth Feedback**
Does the game tell the player they are getting better? Is improvement visible to the player, not just present in outcomes?
*(PENS, motivation research)*

**I12. Knowledge-Gated Progression**
Does the game gate progression primarily through player knowledge and understanding rather than through character stats, unlocks, or time invested? Is a knowledgeable player on a fresh start meaningfully more effective than a naive player with more playtime?
*(Player experience gap — I1-I11 cover mastery depth but don't ask whether knowledge is the primary progression mechanic. Nethack, DCSS, CDDA: knowing how the game works matters more than character power)*

**I13. Lateral Power Acquisition**
Does progression expand the player's option space (more tools, more approaches, more situations they can handle) rather than increasing power level (bigger numbers)? Does late-game gear make early-game gear obsolete, or does it remain situationally relevant?
*(Player experience gap — no existing criterion distinguishes vertical (power) from horizontal (options) progression)*

**I14. Spoiler Independence**
Can the game be understood, played competently, and completed using only in-game information? Are mechanics, item effects, enemy behaviors, and system interactions discoverable through observation and experimentation during play?
*(DCSS "playable without the aid of a guide or wiki," Brogue transparent mechanics, NetHack4, Golden Krone Hotel burden-of-knowledge. Distinct from E1 Data Transparency — this asks whether a player who has NEVER consulted external resources can make informed decisions)*

**I15. Strategy Headroom**
How large is the gap between optimal and naive play? Do strategic and tactical choices have large effects on outcome probability, such that a skilled player dramatically outperforms an unskilled one?
*(NetHack4/Alex Smith "strategy headroom," DCSS "skill must make a real difference," Johnson situational decisions. Distinct from I3 Mastery Depth and I9 Skilled Play Rewarded — this quantifies the MAGNITUDE of the difference)*

---

## J. Pacing & Rhythm

Does the game manage time and tempo well?

**J1. Pacing Quality**
Is the rhythm of play engaging? Does every turn or action move the experience forward?
*(Original auditor, PLAY heuristics)*

**J2. Dead Time Absence**
Are there periods where nothing meaningful happens? Does the player ever wait for the game to do something without having their own decisions to make?
*(Anti-pattern: Dead Time)*

**J3. Decision Rhythm**
Does the game maintain a steady stream of decisions? Is there a natural cadence to the decision-action-feedback loop?
*(Grand strategy research, Game Feel)*

**J4. Escalation**
Does complexity or challenge evolve as play progresses? Does the game get more interesting over time, not less?
*(Original auditor)*

**J5. Front-Loading Resistance**
Does the game maintain or increase depth over time? Or does it get shallower as the player progresses?
*(Anti-pattern: Front-Loaded Depth)*

**J6. Interest Curve**
Does engagement rise and fall in a satisfying rhythm? Are there peaks and valleys that create dramatic structure?
*(Schell — Lens #61)*

**J7. Arc Structure**
Does the game have a well-defined arc from opening through midgame to endgame? Do different phases feel different? Note: this criterion asks whether phases *exist*; B11 (Structural Emergence) asks whether they *emerge from systems* rather than being scripted. A game can score well on J7 but poorly on B11 if its phases are hardcoded rather than emergent.
*(Burgun — clockwork design)*

**J8. Session Structure**
Does the game create natural session boundaries? Can the player find good stopping points, or is the experience formless?
*(Engagement research)*

**J9. Repetition Variation**
When the player repeats activities (which is inevitable in open-ended games), does each repetition introduce enough variation to feel fresh?
*(Anti-pattern: Repetition Without Variation)*

**J10. Downtime Management** `[CONDITIONAL: game has multi-agent turns with player downtime]`
In multi-agent situations (AI factions, etc.), is downtime while others act managed well? Does the player have something to think about or observe during waits?
*(Board game research — BGG)*

**J11. Equilibrium Disruption**
Does the game have mechanisms that prevent it from settling into a solved, stable state? Do internal disruptions periodically upset the player's established patterns and force adaptation? A simulation that reaches equilibrium and stays there is effectively over even if it's still running.
*(Johnson "characters disrupt equilibrium," management research, Sylvester AI storyteller. Distinct from J4 Escalation and J5 Front-Loading Resistance — this asks whether the game ACTIVELY DISRUPTS equilibrium)*

---

## K. Engagement & Compulsion

Does the game create the desire to keep playing?

**K1. One More Turn Compulsion**
Does the game create forward-looking anticipation that makes the player want to continue? Is there always something just ahead to look forward to?
*(Sid Meier)*

**K2. Curiosity Generation**
Does the game raise questions the player wants answered? "What happens if I try X?" "What's in that region?"
*(Schell — Lens #6)*

**K3. Surprise Factor**
Does the simulation produce moments that are unexpected but logically consistent? Not random events — genuine emergent surprises.
*(Schell — Lens #4, original auditor)*

**K4. Discovery Reward**
Does the game reward exploration and discovery of its systems? Is there joy in understanding how things work?
*(MDA — Discovery aesthetic, Bartle — Explorer)*

**K5. Novelty Continuation**
Does the game continue to present novel situations over time? Or does it exhaust its novelty early?
*(Schell — Lens #24)*

**K6. Autotelic Quality**
Is the activity intrinsically rewarding — fun for its own sake, not just as a means to an external goal? Is the core system interesting to manipulate even without goals — would a player want to poke at the simulation to see what happens, before any objectives are layered on?
*(Flow theory — autotelic experience; Wright "toy first, game second")*

**K7. Absorption Potential**
Does the game create conditions where the player can become fully absorbed — losing track of time and self-awareness?
*(Flow theory, GEQ — immersion)*

**K8. Problem-Solving Interest**
Are the problems the game asks the player to solve genuinely interesting? Are they the kind of problems the target audience enjoys?
*(Schell — Lens #8)*

**K9. Competence Satisfaction**
Does the player feel effective and capable within the game? Does successful play create a sense of competence?
*(PENS — competence, GEQ)*

**K10. Narrative Emergence** `[CONDITIONAL: game has enough systemic breadth for narrative emergence]`
Do interacting systems produce "story-worthy" events? Does the player have stories to tell after playing?
*(Emergent narrative research)*

**K11. Narrative Emergence Rate** `[CONDITIONAL: game has enough systemic breadth for narrative emergence]`
How frequently do story-worthy emergent events occur? Often enough to be a feature, not so often they lose impact?
*(Emergent narrative research)*

**K12. Discoverable Systemic Interactions**
Does the game contain meaningful system interactions the player can discover through experimentation rather than being told? Are there "aha moments" where the player realizes two systems interact in a useful way they hadn't been shown? Is the space of undocumented-but-functional interactions large enough for ongoing discovery?
*(Player experience gap — K4 is about content discovery; B2 is about system-level emergence; this is about player-driven discovery of how systems compose. Nethack's unicorn horn, Caves of Qud's spray-a-brain)*

**K13. Non-Prescriptive Problem Structure**
Does the game present problems without indicating a correct solution method? When the player faces a challenge, does the game leave the approach entirely to the player, or does it signal how the problem "should" be solved (highlighted weak points, quest markers, obvious patterns)?
*(Player experience gap — L8 checks for multiple solution paths; this checks whether the game avoids signaling a preferred solution. "The game respects my intelligence" traces to this pattern)*

---

## L. Player Agency & Freedom

Does the player feel in control of their experience?

**L1. Autonomy**
Does the player feel that their choices are self-directed and meaningful? Are they driving the experience or being driven?
*(PENS — autonomy, SDT)*

**L2. Freedom**
Does the player feel free within the game, or constrained by its structure? Can they pursue their own goals?
*(Schell — Lens #71)*

**L3. Player-as-Star**
Does the game make the player feel like the protagonist of their experience? Is the game about the player, not about the system?
*(Sid Meier)*

**L4. Player Authorship**
Does the player feel they authored what happened through their decisions? Is the outcome theirs?
*(Emergent narrative research)*

**L5. Recovery from Errors**
Can the player recover from mistakes without catastrophic consequences? Is error part of play, or does one mistake end the experience?
*(GameFlow, PLAY heuristics, Pinelle)*

**L6. Token Identification**
Can the player identify with their game token / avatar / position / faction? Do they feel ownership over their in-game identity?
*(Costikyan)*

**L7. Expression**
Does the game allow self-expression and identity crafting? Can the player play in a way that reflects their personality?
*(MDA — Expression aesthetic)*

**L8. Multiple Solution Paths**
Can problems be solved in multiple ways? Is there more than one valid approach to any given challenge?
*(Berlin interpretation — complexity, roguelike design)*

**L9. Autonomy Respect**
Does the game avoid forcing the player down a single path? Are there meaningful branches, not just the illusion of branching?
*(Player agency research)*

**L10. Mechanical Identity Expression**
Can the player develop a mechanically distinct playstyle — a way of engaging with the systems that is functionally different from other approaches, not just cosmetically different? Can two experienced players play fundamentally different "games" within the same system (pacifist run, merchant run, combat specialist, builder)?
*(Player experience gap — L7 Expression includes cosmetics; I6 Skill-Expression is about skill variance; this is about structurally different ways of being a player in the world. Kenshi, Rimworld, CDDA)*

---

## M. Motivation & Reward

Does the game motivate the player effectively?

**M1. Intrinsic Motivation Support**
Is the activity itself rewarding? Does mastery, discovery, or expression feel good independent of external rewards?
*(SDT, PENS, motivation research)*

**M2. Extrinsic Motivation Appropriateness**
Are external rewards (scores, unlocks, level-ups) additive rather than replacing intrinsic motivation? Do they enhance or cannibalize the fun?
*(Motivation research — overjustification effect)*

**M3. Reward-Effort Correlation**
Do greater challenges yield greater rewards? Is the payoff proportional to the investment?
*(Motivation research)*

**M4. Reward Type Variety**
Does the game offer multiple types of rewards — power, knowledge, access, narrative consequence? Or is it just "number go up"?
*(Motivation research)*

**M5. Reward Predictability Balance**
Are some rewards predictable (motivating goal pursuit) and some surprising (exciting discovery)?
*(Motivation research)*

**M6. Achievement Measurement**
Does the game provide concrete measurements of success? Can the player tell how well they're doing?
*(Bartle — Achiever, GEQ)*

**M7. Judgment Fairness**
Is the game's judgment of the player (scoring, feedback, outcomes) perceived as fair and motivating rather than arbitrary or punishing?
*(Schell — Lens #25)*

**M8. Reward-to-Punishment Ratio**
Does the game reward success proportionally more than it punishes failure? (Roughly 2:1 is a known heuristic for maintaining motivation.)
*(Sid Meier)*

**M9. Reward Without Achievement Absence**
Does the game avoid dispensing rewards for trivial actions? Are rewards earned, not given?
*(Anti-pattern: Reward Without Achievement)*

---

## N. Aesthetic & Thematic Coherence

Does the game have a consistent identity?

**N1. Fantasy Enablement**
Does the game enable make-believe? Can the player inhabit an alternate identity or imagine themselves in the game's world?
*(MDA — Fantasy aesthetic)*

**N2. Theme Integration**
Is the theme reflected in the mechanics? Or is it pasted on — would the same mechanics work with any theme?
*(Board game research — BGG, Schell)*

**N3. Tonal Consistency**
Does the game maintain a consistent emotional atmosphere? Do mechanical, textual, and structural elements all point the same direction?
*(Board Game Halv — Tone, Ludum Dare — Mood)*

**N4. Unification**
Does every element serve a single unifying vision? Or does the game feel like a collection of unrelated parts?
*(Schell — Lens #11)*

**N5. Holographic Design**
Does every element of the game reinforce every other element? Is the design integrated or fragmented?
*(Schell — Lens #10)*

**N6. Imagination Fuel**
Does the game provide enough concrete, specific detail for the player to build a mental picture? "A room" is barren. "A vaulted stone hall, torch-smoke under the ceiling, three iron doors" gives the imagination material.
*(Original auditor, CLI research)*

**N7. ASCII Art Effectiveness** `[CONDITIONAL: game uses ASCII art]`
If ASCII art is used, does it communicate spatial information clearly? Is it readable and functional, not just decorative? See Category V for comprehensive visual representation criteria.
*(CLI research)*

**N8. Aesthetic Coherence**
Does the game have a consistent visual/tonal identity across all its outputs? Is there a recognizable style?
*(Schell — Lens #63)*

**N9. Resonance**
Does the game feel like it is about something that matters — even in a fictional context? Does it create meaning beyond its mechanics?
*(Schell — Lens #12)*

**N10. Functional Space** `[CONDITIONAL: game has spatial design]`
Does the game's spatial design (if any) serve gameplay? Is geography meaningful, not just decorative?
*(Schell — Lens #26)*

---

## O. Balance & Stability

Is the game balanced and resistant to degenerate play?

**O1. Dominant Strategy Absence**
Is there no single strategy that beats all others regardless of context? Are multiple approaches competitive?
*(Zileas, Costikyan, Burgun, Salen/Zimmerman)*

**O2. Exploit Resistance**
Does the game resist degenerate strategies? Can a player break the game by exploiting rules loopholes?
*(MDA — dynamics, anti-pattern research)*

**O3. AI Manipulation Resistance**
Can the player trivially manipulate AI behavior to avoid challenge? Do AI opponents resist being "cheesed"?
*(Anti-pattern: AI Manipulation)*

**O4. Snowball Resistance**
Does the game prevent early advantages from becoming insurmountable? Can a trailing player catch up through good play?
*(4X research, anti-pattern: Runaway Leader)*

**O5. Death Spiral Resistance**
Does the game prevent early disadvantages from becoming irrecoverable? Does falling behind compound into a death spiral?
*(Anti-pattern: Death Spiral)*

**O6. Option Viability**
Are all presented options roughly competitive? Are there options or resources that are never worth choosing?
*(Original auditor, balance research)*

**O7. Grinding Non-Viability**
Is grinding (spending time on trivial repeated actions to bypass challenge) an unviable strategy? Does the game incentivize engagement over repetition?
*(Anti-pattern: Grinding Viability, Harris — Reducing Grind)*

**O8. Difficulty Scaling**
Does monster/obstacle difficulty scale in a way that maintains pressure? Does challenge keep up with player power growth?
*(Harris — Race You Can't Win)*

**O9. Two-Sided Coin**
Do powerful items/abilities carry meaningful drawbacks? Is power free, or does it come with costs?
*(Harris — Two-Sided Coin)*

**O10. Sequence Break Resistance**
Is the intended progression robust? Can the player bypass the designed difficulty curve through unintended mechanics?
*(Anti-pattern: Sequence Breaking)*

**O11. Asymmetric Balance** `[CONDITIONAL: game has asymmetric options]`
If different starting conditions, factions, or characters exist, are they balanced while being distinct? Is asymmetry interesting rather than unfair?
*(Grand strategy research, 4X research)*

**O12. Situational Tool Value**
Are the game's tools, items, abilities, or options situationally rather than universally valuable? Does the optimal choice shift depending on context (enemy type, terrain, resource state, strategic phase)? Must the player evaluate each situation to determine which tools to use?
*(Player experience gap — O1 checks for dominant strategy absence globally; this checks whether optimal choice varies with context. DCSS: best choice shifts radically per encounter)*

---

## P. Interface & Usability

Is the game easy to interact with?

**P1. Response Immediacy**
Does the game respond instantly to input? Is there lag between command and result?
*(Game Feel — Swink, CLI research)*

**P2. Control Consistency**
Does the game respond consistently to the same input? Are there situations where the same command does different things?
*(Pinelle heuristics, PLAY)*

**P3. Command Discoverability**
Can the player find out what actions are available without external documentation? Are available commands listed, hinted, or naturally discoverable?
*(CLI research)*

**P4. Input Efficiency**
Can common actions be performed with minimal keystrokes? Is the input scheme ergonomic for frequent use?
*(CLI research)*

**P5. Output Density Calibration**
Is text output dense enough to be informative but not so dense as to be overwhelming? Is the output quantity matched to the information content?
*(CLI research)*

**P6. Contextual Help**
Can the player access help for their current situation without leaving the game?
*(CLI research)*

**P7. Turn Structure Clarity**
Is it always clear when the player should act and what constitutes a "turn" or action unit?
*(CLI research)*

**P8. Navigable Interface**
Can the player navigate the interface efficiently? Are menus, if present, logically organized and not too deep?
*(Pinelle heuristics)*

**P9. Memory Burden**
Does the game avoid requiring the player to memorize arbitrary information that could be displayed?
*(Pinelle heuristics, PLAY)*

**P10. Error Recovery**
Can the player recover from input errors? Can mistaken commands be undone or do they have permanent consequences?
*(Pinelle heuristics, PLAY)*

**P11. Status Visibility**
Is the player's current status always visible or easily accessible? Can they check health, resources, position, etc. at any time?
*(GameFlow, PLAY)*

**P12. Save/Load Transparency**
Is the persistence model clear? Does the player know whether the game auto-saves, uses permadeath, or allows free saves?
*(CLI research)*

**P13. Output Proportionality**
Is the length and detail of game output proportional to the importance of the event described? Do trivial actions produce brief confirmations while significant events receive detailed descriptions?
*(IF, MUD, roguelike traditions — universal cross-tradition principle. Distinct from P5 and E3 — this asks whether output LENGTH dynamically scales with importance)*

**P14. Tedium Automation**
Does the game automate or abbreviate actions that involve no meaningful decision? Are repetitive non-choice sequences handled automatically or with a single command?
*(DCSS auto-explore, Cogmind automated inventory, Graham Nelson Player's Bill of Rights. Distinct from P4 Input Efficiency — this asks whether the game identifies and automates SEQUENCES where no decision exists)*

---

## Q. AI & Opposition `[CONDITIONAL: game has AI agents/opponents]`

How well do AI agents behave?

**Q1. AI Believability**
Does the AI behave in ways that seem rational and intentional? Does it make decisions that a human player would find plausible?
*(PLAY heuristics)*

**Q2. AI Personality**
Do different AI entities behave in observably different ways based on their attributes, goals, or faction identity? Does AI behavior reflect personality and character rather than optimal play — do AI actors roleplay their identity rather than uniformly pursuing the best strategy?
*(Emergent narrative research; Paradox "the AI isn't here to win, it's here to roleplay")*

**Q3. AI Fairness**
Does the AI play by the same rules as the player? Or does it cheat (omniscient, unlimited resources, etc.)?
*(Berlin interpretation — Monsters as similar to players)*

**Q4. AI as Opposition**
Does the AI provide meaningful opposition? Is it challenging enough to require the player to think?
*(Costikyan — Opposition/Struggle)*

**Q5. AI Predictability Balance**
Is AI behavior predictable enough to strategize against but unpredictable enough to require adaptation?
*(Uncertainty research — Player Unpredictability)*

---

## R. Variety & Replayability

Does the game offer variety across playthroughs?

**R1. Procedural Generation Quality** `[CONDITIONAL: game uses procedural generation]`
If the game uses procedural generation, does it produce meaningfully different situations? Or does it produce superficial variation (different numbers, same structure)?
*(Berlin interpretation, roguelike design)*

**R2. Playthrough Variation**
Do different playthroughs feel meaningfully different? Does the game produce distinct experiences, not just reshuffled sameness?
*(Original auditor, board game research)*

**R3. Starting Condition Variety** `[CONDITIONAL: game has multiple starting conditions]`
Do different starting positions, factions, or characters create genuinely different strategic situations?
*(Grand strategy research, 4X research)*

**R4. Player-Driven Variety**
Does the variety come from player choices (different strategies, different priorities) rather than just from randomization?
*(Original auditor)*

**R5. Long-Term Replayability**
After many playthroughs, is the game still worth playing? How many runs until the player has "seen everything"?
*(Board game research — BGG)*

**R6. Phase Differentiation**
Do different phases of a single playthrough (early/mid/late game) feel meaningfully different from each other?
*(4X research — phase balance, Burgun — arc structure)*

**R7. Procedural Tactical Differentiation** `[CONDITIONAL: game uses procedural generation]`
Does procedurally generated content demand different strategies, not just present different layouts? Do generated situations create tactically distinct challenges requiring adaptation?
*(Cogmind hybrid generation, Spelunky, Golden Krone Hotel. Distinct from R1 and C4 — this specifically asks whether variation is TACTICALLY significant)*

**R8. Graduated Victory Conditions** `[CONDITIONAL: game has defined victory/completion]`
Does the game offer multiple victory conditions at different mastery levels? Beyond the baseline win, are there optional harder goals for expert players?
*(Cogmind, DCSS optional runes, ADOM multiple endings, Brogue lumenstones. Distinct from T5 and T4 — this asks for a LADDER of increasingly difficult formal objectives)*

---

## S. Completeness & Polish

Are the game's systems fully realized?

**S1. Mechanical Completeness**
Are all mechanics fully realized? Does every system present contribute meaningfully, or are some half-finished stubs?
*(Original auditor)*

**S2. Dead Mechanic Absence**
Are there systems that exist but don't affect gameplay? Features that are present but non-functional or irrelevant?
*(Anti-pattern: Dead Mechanics)*

**S3. Orphan Mechanic Absence**
Are there systems with no connection to other systems? Isolated mechanics that don't interact with anything else?
*(Anti-pattern: Orphan Mechanics)*

**S4. Vestigial Mechanic Absence**
Are there systems that appear to be remnants of a different design — still present but no longer serving a purpose?
*(Anti-pattern: Vestigial Mechanics)*

**S5. Feature Scope Match**
Does the scope of each feature match its importance? Are important systems deep and minor systems appropriately light? Or are trivial features over-built while core features are thin?
*(General design principle)*

**S6. Anti-Combo Absence**
Do the player's abilities/items/systems work together rather than undermining each other?
*(Zileas — Anti-Combo)*

**S7. Use Pattern Coherence**
Do abilities/actions require the player to act consistently with their role/strategy? Or must they do counterintuitive things to play optimally?
*(Zileas — Use Pattern Mismatch)*

---

## T. Goal Structure

Does the player know what to strive for?

**T1. Goal Clarity**
Does the player understand what they are working toward? Are objectives (or self-directed goals) legible?
*(Costikyan, Flow theory, GameFlow, original auditor)*

**T2. Goal Hierarchy**
Are there goals at multiple timescales — immediate (this turn), short-term (this session), long-term (this campaign)?
*(GameFlow — clear goals)*

**T3. Goal Achievability**
Are goals achievable through the player's own actions? Or do they depend on luck or AI cooperation?
*(GameFlow — clear goals)*

**T4. Competing Objectives**
Are there multiple objectives that conflict, requiring the player to prioritize? Or is there a single clear goal with no tension?
*(Decision design, strategy research)*

**T5. Open-Ended Goal Support**
For sandbox/open-ended games: does the game provide enough structure for self-directed goal-setting? Can the player create their own objectives and pursue them meaningfully?
*(Original auditor)*

---

## U. Specific Design Lenses

Additional evaluable dimensions from specific frameworks that don't fit neatly elsewhere.

**U1. Emotion Alignment**
What emotions does the game evoke? Are they the ones it appears to intend?
*(Schell — Lens #1)*

**U2. Essential Experience**
What experience is the game trying to create? Does every element serve that experience, or are there distractions?
*(Schell — Lens #2)*

**U3. Conflict Structure**
Is the game's core conflict well-defined and engaging? Is it clear what the player is struggling against?
*(Salen/Zimmerman)*

**U4. Multiple Pleasure Types**
Does the game produce multiple types of pleasure? (Intellectual satisfaction, discovery joy, power fantasy, optimization satisfaction, etc.)
*(Schell — Lens #20)*

**U5. Cultural Rhetoric**
Does the game say something through its systems? Do the mechanics make an implicit argument about how the world works?
*(Salen/Zimmerman, MIT CMS.300)*

**U6. Item Enhancement** `[CONDITIONAL: game has improvable items/elements]`
Can items/units/elements be improved through gameplay actions? Is there growth and customization within the game's object model?
*(Harris — Item Enhancement)*

**U7. Identification System Quality** `[CONDITIONAL: game has unidentified elements]`
If the game has unidentified elements (items, factions, map tiles), does the identification process resist trivialization through external knowledge (wikis, spoilers)?
*(Harris — Item Masquerade, Situational ID Advantage)*

**U8. Power Without Gameplay Absence**
Are there mechanics that provide benefit without the player noticing or making decisions about them? (Passive buffs with no interaction, etc.)
*(Zileas — Power Without Gameplay)*

**U9. Anti-Fun Balance**
Does any mechanic's negative impact exceed its positive value? Are there systems that make the game worse for the player experiencing them than they make it better for anyone?
*(Zileas — Anti-Fun Exceeds Fun)*

**U10. Interaction Richness**
How many distinct, meaningful ways can the player interact with the game system? Is the verb set rich or impoverished?
*(Costikyan)*

**U11. Information Management as Gameplay**
Does the game require the player to gather, process, and act on information as a core gameplay loop? Is information a resource to be managed?
*(Costikyan)*

**U12. Genre Awareness**
Does the game demonstrate awareness of its genre's conventions? Does it follow them where they work and deviate where it has a reason to?
*(MIT CMS.300)*

---

## V. Visual Representation & ASCII Graphics

How effectively does the game use visual elements (ASCII art, diagrams, maps, gauges, charts) to enhance comprehension and experience?

**V1. Spatial Representation Appropriateness**
When the game involves spatial relationships that affect decisions (movement, positioning, layout, adjacency), does it provide a visual spatial display (map, grid, diagram) rather than describing spatial information only in text? A game about navigating a space station, arranging a store layout, or positioning a squad that provides no visual map has missed its most natural representation.
*(Roguelike universal convention, Cogmind, Brogue, Dwarf Fortress)*

**V2. Quantity Visualization** `[CONDITIONAL: game has quantities the player monitors]`
Does the game use visual gauges (bars, meters, proportional fills) for quantities the player must monitor or compare quickly? `[████████░░] 80%` communicates urgency faster than `HP: 80/100`. Resources, health, morale, progress — any value that changes and matters should have a visual representation, not just a number.
*(Terminal visualization research, roguelike HP bars, Cogmind status displays)*

**V3. Entity Visual Identity** `[CONDITIONAL: game has entities whose individual identity matters]`
When individual entities matter (named characters, specific opponents, unique items), does the game provide visual differentiation beyond text labels? Procedural portraits, distinct item art, faction heraldry — any visual element that makes one entity recognizable and distinct from others of the same type.
*(Warsim 202Q+ procedural faces, Cogmind item art, Paradox character portraits)*

**V4. Structural Diagramming** `[CONDITIONAL: game has structures with meaningful layout]`
When the game involves structures with meaningful spatial arrangement (vehicle components, building layouts, body parts, network topology, mechanical assemblies), does it provide diagrams showing the structure visually? A car engine where part arrangement matters, a network with connected nodes, a character's body with damaged regions — these benefit from visual representation.
*(Dwarf Fortress z-level cross-sections, CDDA vehicle displays, body part damage diagrams)*

**V5. Visual Representation Absence**
Are there game elements that would clearly benefit from visual representation but receive none? This is the inverse of the other criteria — detecting missed opportunities. A fishing game with no depiction of the water/depth, a combat game with no position diagram, a management game with no visual dashboard of trends. When a visual would obviously help the player and the game provides only text, that is a gap.
*(Cross-reference with concept requirements — spatial, structural, or comparative information presented only as text)*

**V6. Symbol Consistency**
Does every visual symbol, character, or glyph have a consistent meaning throughout the game? If `#` means wall in one display and dense forest in another with no clear context distinction, the visual vocabulary is broken. Consistent symbol-meaning mapping is what makes ASCII displays learnable rather than cryptic.
*(Roguelike conventions, Mark R. Johnson academic research on ASCII semiotics, CDDA symbol system)*

**V7. Visual Readability**
Can the player extract key information from visual displays quickly? Is there clear figure/ground separation — important elements visually distinct from background? Does the display use negative space to make occupied areas prominent? A dense wall of characters where nothing stands out defeats the purpose of visual representation.
*(Cogmind deliberate negative space, Brogue color contrast, visual density research)*

**V8. Color Semantics** `[CONDITIONAL: game uses color]`
Does color encode consistent gameplay-relevant categories (material type, urgency level, faction identity, damage state) rather than being applied arbitrarily? Systematic color coding is information; random color is noise. Red for danger/damage, green for health/safety, yellow for caution — these conventions exist because they work. Games that use color without semantic consistency waste a powerful information channel.
*(Cogmind weapon color categories, Brogue terrain/lighting colors, Dwarf Fortress material colors)*

**V9. Decorative vs. Functional Art**
Does all ASCII art in the game communicate something the player can use (identity, spatial relationship, status, structure, atmosphere), or is some purely decorative filler that consumes screen space without informing decisions? Large title cards, ornamental borders, and illustrative drawings that push game information off-screen are clutter. Art must earn its screen space.
*(Cogmind "lots of black when nothing is happening," anti-pattern research)*

**V10. Dynamic Visual Updates** `[CONDITIONAL: game has visual representations of changing state]`
When ASCII art represents something that changes (a map with moving entities, a health bar, a building under construction, a damaged vehicle), does the display update to reflect the current state? Static illustrations for dynamic information become lies when the underlying data changes and the art doesn't.
*(Brogue animated water/fire/lighting, Cogmind particle effects, CDDA seasonal terrain)*

**V11. Art-Information Integration**
Does ASCII art appear alongside functional information rather than displacing it? A portrait of an NPC should accompany their stats and dialogue options, not replace them. Diagrams should label their components. Maps should include a legend if symbols are non-obvious. Visual and textual information should complement each other.
*(IF/MUD tradition, Cogmind item art alongside stats)*

**V12. Medium-Appropriate Abstraction**
Does the ASCII art use abstraction appropriate to text rendering rather than attempting photorealism? Text characters cannot render curves, gradients, or fine detail. Semi-abstract line art that suggests form and lets the player's imagination complete the picture is more effective than 40-line attempts at realistic drawings that resolve into noise. Simpler is usually better.
*(Cogmind "semi-abstract line art," Stone Story RPG symbol language, Warsim modular face components)*

---

## Summary

| Category | Count |
|----------|-------|
| A. Rules & Formal Structure | 10 |
| B. Systems & Emergence | 14 |
| C. World & Simulation | 14 |
| D. Decision Architecture | 19 |
| E. Information Design | 17 |
| F. Uncertainty & Randomness | 12 |
| G. Economy & Resource Design | 9 |
| H. Challenge & Difficulty | 14 |
| I. Learning & Mastery | 15 |
| J. Pacing & Rhythm | 11 |
| K. Engagement & Compulsion | 13 |
| L. Player Agency & Freedom | 10 |
| M. Motivation & Reward | 9 |
| N. Aesthetic & Thematic Coherence | 10 |
| O. Balance & Stability | 12 |
| P. Interface & Usability | 14 |
| Q. AI & Opposition | 5 |
| R. Variety & Replayability | 8 |
| S. Completeness & Polish | 7 |
| T. Goal Structure | 5 |
| U. Specific Design Lenses | 12 |
| V. Visual Representation & ASCII Graphics | 12 |
| **Total** | **252** |
