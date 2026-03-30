# Category W: Code Architecture & Iteration Quality

You are evaluating the game's source code as a codebase — how well-structured it is for maintainability, testability, and ease of iteration. You are NOT evaluating the player experience (other categories handle that). Read all source files and assess the implementation.

## Criteria and Evaluation Instructions

### W1. Data-Driven Content Definition (0-5)

Examine how game entities (items, enemies, abilities, events, terrain) are defined. Check:
- Are entity properties defined in data structures (config dicts, data files, constant tables) separate from the logic that processes them?
- Can a new item/enemy/event be added by creating a new data entry without changing game logic?
- Or are entity properties hardcoded as literals scattered through game functions?

Score 0 if all content is hardcoded inline — adding a new weapon requires editing combat resolution logic, not a data table. Score 2 if some content is data-driven but significant content is still hardcoded. Score 4 if all game content is defined in data with clear separation from processing logic — adding content means adding a data entry.

### W2. Simulation-Display Separation (0-5)

Search the source code for display/IO calls inside simulation logic. Check:
- Do functions that compute game outcomes (combat resolution, resource calculation, AI decisions) contain `print()`, `input()`, or formatting code?
- Could the simulation run headless (with all print/input removed) without breaking?
- Is there a clear boundary between "compute what happens" and "show what happened"?

Score 0 if display and simulation are thoroughly interleaved — print statements inside combat formulas, input calls inside AI decision functions. Score 2 if most simulation is clean but some display calls leak into logic. Score 4 if simulation logic is completely free of IO — all display happens in a separate layer that reads simulation results.

### W3. System Modularity (0-5)

Examine the boundaries between game systems. Check:
- Can you identify where one system ends and another begins?
- Do systems interact through defined interfaces (function calls with clear parameters) or through shared mutable state?
- Could you modify how combat works without understanding or changing the economy code?

Score 0 if systems are entangled — changing one mechanic requires understanding and modifying multiple unrelated systems. Score 2 if some systems are cleanly separated but others are tightly coupled. Score 4 if each system has clear boundaries and interacts with others only through defined interfaces.

### W4. God Object Absence (0-5)

Look for a single class, module, or file that accumulates unrelated responsibilities. Check:
- Is there one file that handles game loop, state management, input, display, and multiple game systems?
- Does one class have methods for combat, economy, UI, saving, and AI?
- Or are responsibilities distributed across focused modules?

Score 0 if a single file handles most of the game's functionality — a monolithic game.py that does everything. Score 2 if responsibilities are partially distributed but one central file still handles too many concerns. Score 4 if responsibilities are well-distributed — each module handles one domain with clear purpose.

### W5. State Serialization Quality (0-5) `[CONDITIONAL: game has save/load]`

Examine how game state is saved and loaded. Check:
- Is the save format structured and readable (JSON, YAML, readable text)?
- Does save/load handle the complete game state (not just some of it)?
- Are object cross-references handled by ID rather than direct reference?

Score 0 if save/load is broken, incomplete, or uses an opaque format that can't be inspected. Score 2 if save/load works but the format is fragile or incomplete. Score 4 if save/load uses a clean structured format that captures complete game state and handles cross-references properly.

### W6. Testability (0-5)

Assess whether the code can be tested. Check:
- Can game systems be instantiated and tested without initializing the full game?
- Could you write a script that runs 100 simulated combats without any display?
- Is game state deterministic given the same random seed?
- Are there any existing tests or validation?

Score 0 if the code is untestable — everything requires full game initialization, simulation and display are inseparable, no deterministic mode. Score 2 if some systems can be tested in isolation but the architecture makes comprehensive testing difficult. Score 4 if the code is designed for testability — systems can be instantiated independently, simulation runs headless, deterministic mode available.

### W7. Configuration Centralization (0-5)

Search for numeric literals in game logic. Check:
- Are balance values (damage, health, costs, probabilities) defined as named constants or config entries?
- Or are they scattered as magic numbers throughout the code (`if hp < 20:`, `damage = attack * 1.5 - defense * 0.8`)?
- Could someone tune balance by editing one file, or would they need to search the entire codebase?

Score 0 if magic numbers are pervasive — balance values are literals scattered through game logic with no central definition. Score 2 if some values are centralized but significant magic numbers remain. Score 4 if all balance values are defined in a central config with descriptive names — tuning means editing one place.

### W8. Content Extensibility (0-5)

Assess how much work is needed to add new content. Check:
- Is there a clear pattern for adding a new item/enemy/event? (A template to follow, a data file to extend)
- Does adding content require modifying core game logic, or just adding a data entry?
- How many files must be touched to add one new entity?

Score 0 if adding content requires modifying multiple core files and understanding the full codebase. Score 2 if there's a pattern but it requires touching both data and logic. Score 4 if there's a clear, documented extension point — adding content means creating a new entry in one place following an obvious pattern.

### W9. Code Navigability (0-5)

Assess the code's organization. Check:
- Do filenames clearly indicate their contents?
- Are files reasonably sized (under ~500 lines each)?
- Is code organized by domain (combat.py, economy.py, ai.py) or dumped into one or two files?
- Are function and variable names descriptive?

Score 0 if the code is a navigational nightmare — one or two huge files, unclear naming, no domain organization. Score 2 if some organization exists but key areas are hard to find. Score 4 if the codebase is well-organized — clear file names, reasonable file sizes, domain-based organization, descriptive naming throughout.

### W10. Duplication Absence (0-5)

Search for repeated code patterns. Check:
- Are there near-identical blocks of code (entity definitions, handler functions, validation logic) that could be abstracted?
- Is there copy-paste code where a shared utility or base class should exist?
- Do similar entities share common code, or does each reimplement the same patterns?

Score 0 if the code is full of copy-paste — similar entity definitions, repeated handler patterns, duplicated logic blocks that differ only in variable names. Score 2 if some abstraction exists but notable duplication remains. Score 4 if the code consistently uses abstraction to eliminate redundancy — shared utilities, base classes, data-driven patterns where appropriate.

### W11. Entity Composition (0-5) `[CONDITIONAL: game has multiple entity types with shared behaviors]`

Examine how game entities are constructed. Check:
- Are entities composed from reusable components/behaviors, or built through deep inheritance hierarchies?
- Can entity behavior be changed by attaching/detaching components?
- Could a new entity type be created by combining existing building blocks?

Score 0 if entities use deep rigid inheritance where adding a new type requires understanding the full class tree. Score 2 if some composition exists alongside inheritance. Score 4 if entities are built from composable components — new types can be created by combining existing behaviors without new classes.

### W12. Dependency Clarity (0-5)

Trace the dependency structure. Check:
- Are imports/dependencies between modules acyclic and traceable?
- Is there global mutable state accessed from multiple modules?
- Can you understand what a module depends on by reading its imports?

Score 0 if dependencies are circular, global state is accessed everywhere, and you can't modify one module without understanding all others. Score 2 if most dependencies are clear but some hidden coupling exists through shared state. Score 4 if dependencies are explicit, acyclic, and traceable — each module's dependencies are visible in its imports and it doesn't reach into other modules' internals.

### W13. Debug Mode / State Manipulation (0-5)

Check whether the game includes tools for jumping to specific states. Check:
- Can a developer spawn entities, trigger events, set time, or force conditions without playing through the game?
- Is there a debug menu, console, cheat mode, or arena/sandbox mode?
- Can late-game content be tested without playing through the early game?

Score 0 if there is no way to manipulate game state except by playing normally — testing late-game content requires playing through the entire early and mid game. Score 2 if some manipulation exists (e.g., cheat codes for resources) but you can't reach arbitrary game states. Score 4 if the game has comprehensive state manipulation — spawn anything, teleport anywhere, trigger any event, set any variable — enabling any game state to be reached in seconds.

### W14. Headless / Automated Testability (0-5)

Check whether the simulation can run without human interaction. Check:
- Can the game run without display or input for automated testing?
- Could you script 100 simulated games to gather balance data?
- Can game systems be exercised programmatically (import and call functions directly)?

Score 0 if the game requires interactive input for every turn and cannot run unattended — no way to automate playtesting. Score 2 if some systems can be called programmatically but the full game loop requires human input. Score 4 if the simulation can run fully headless with scripted input, enabling automated balance testing, regression testing, and Monte Carlo simulation.

### W15. Deterministic Reproducibility (0-5)

Check whether identical inputs produce identical outputs. Check:
- Given the same random seed, does the game produce the same procedural content and outcomes?
- Are seeds exposed (visible to the player or developer) for reproduction?
- Could a bug report include a seed that reproduces the exact scenario?

Score 0 if the game has no seed system and no way to reproduce a specific game session. Score 2 if seeds exist but are not exposed, or determinism is approximate (mostly the same but with minor variations). Score 4 if the game is fully deterministic given a seed, seeds are exposed and logged, and any game session can be reproduced exactly.

### W16. Data Validation at Load Time (0-5)

Check whether the game validates its own data. Check:
- Does loading data files check for invalid values (negative health, probabilities > 1, missing required fields)?
- Does it check reference integrity (item references valid material, enemy references valid attack)?
- Does it produce clear error messages identifying what's wrong and where?

Score 0 if there is no data validation — malformed data causes silent corruption or cryptic runtime errors. Score 2 if some validation exists but gaps remain (some fields unchecked, some references unvalidated). Score 4 if data loading includes comprehensive validation with clear, actionable error messages for every failure mode.

### W17. State Inspection During Play (0-5)

Check whether internal state is observable. Check:
- Can the developer see the exact value of any game variable during play?
- Is there an inspect command, debug overlay, or state dump?
- Can AI decision state, pending events, and hidden variables be viewed?

Score 0 if internal state is completely opaque during play — understanding what's happening requires reading source code and adding print statements. Score 2 if some state is visible (e.g., a status command shows player stats) but internal systems are opaque. Score 4 if comprehensive state inspection is available — any game object's full internal state can be viewed on demand during play.

### W18. Game Speed Control (0-5) `[CONDITIONAL: game has time-based simulation]`

Check whether simulation speed is controllable. Check:
- Can the game be run at accelerated speed to observe long-term dynamics?
- Can it be paused for inspection?
- Is there a fast-forward or skip-to-turn-N capability?

Score 0 if the game runs at one fixed speed with no acceleration or pause. Score 2 if pause exists but no acceleration, or acceleration is limited (2x only). Score 4 if the game supports flexible speed control — pause, normal, fast, and very fast — enabling long-term dynamics to be observed in minutes.
