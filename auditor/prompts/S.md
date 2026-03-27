# Category S: Completeness & Polish

You are evaluating whether the game's systems are fully realized and internally coherent. Focus on identifying incomplete, dead, orphaned, or vestigial mechanics — systems that exist in the code but fail to contribute meaningfully to the gameplay experience.

## Criteria and Evaluation Instructions

### S1. Mechanical Completeness (0-5)

Inventory every mechanic and system in the game. For each one, check:
- Is it fully implemented — does it have all the behaviors, interactions, and outcomes it needs to function as intended?
- Are there systems that are partially built — present in the code but missing key functionality (e.g., a crafting system with recipes defined but no way to gather ingredients)?
- Does every system that exists actually do something during gameplay?

Score 0 if multiple systems are stub implementations — they exist in the code but lack the functionality needed to affect gameplay meaningfully. Score 2 if most systems are complete but one or two have noticeable gaps where expected functionality is missing. Score 4 if every system in the game is fully realized — each one does everything it appears designed to do, with no half-built features.

### S2. Dead Mechanic Absence (0-5)

Search for mechanics that are present but have no effect on gameplay. Check:
- Are there stats, attributes, or resources that are tracked but never influence any outcome?
- Are there actions available to the player that produce no meaningful result?
- Are there systems that run in the background but whose outputs are never consumed by any other system?

Score 0 if multiple mechanics exist that have zero impact on gameplay — they are tracked, displayed, or computed but nothing in the game responds to them. Score 2 if most mechanics are functional but one or two stats, resources, or systems exist without clear gameplay impact. Score 4 if every mechanic in the game visibly affects gameplay — nothing is tracked without purpose, nothing is computed without consequence.

### S3. Orphan Mechanic Absence (0-5)

Map the connections between the game's systems. For each system, check:
- Does it interact with at least one other system?
- Are there isolated systems that operate in their own silo — they function internally but have no inputs from or outputs to any other part of the game?
- Could any system be removed entirely without any other system noticing?

Score 0 if multiple systems are completely isolated — self-contained islands with no interaction with the rest of the game. Score 2 if most systems are connected but one or two operate independently with weak or no connections to other systems. Score 4 if every system both influences and is influenced by at least one other system — the game is a connected graph with no isolated nodes.

### S4. Vestigial Mechanic Absence (0-5)

Look for mechanics that appear to be leftovers from a different design. Check:
- Are there systems that seem to belong to a different game — their logic doesn't connect to the current design's goals?
- Are there mechanics whose purpose is unclear because the context that would have made them meaningful is missing?
- Are there systems that work but serve no apparent design purpose in the current game?

Score 0 if multiple mechanics appear vestigial — they function but seem designed for a different game than the one that exists. Score 2 if most mechanics fit the current design but one or two feel like they belong to an earlier version or a different concept. Score 4 if every mechanic clearly belongs to the current design — nothing feels like a remnant, nothing requires imagining a different game to understand its purpose.

### S5. Feature Scope Match (0-5)

Compare each feature's implementation depth to its importance in the game. Check:
- Are the game's most important systems (the ones the player interacts with most) the deepest and most polished?
- Are minor or peripheral features appropriately lightweight, or are they over-engineered relative to their importance?
- Is the core mechanic the most developed system in the game, or do secondary systems receive disproportionate attention?

Score 0 if scope allocation is inverted — peripheral features are deeply developed while the core mechanic is thin and underbuilt. Score 2 if scope generally correlates with importance but one or two secondary features are over-built or one core feature is under-developed relative to its centrality. Score 4 if implementation depth precisely matches importance — the core mechanic is the deepest, secondary systems are appropriately developed, and nothing peripheral is over-engineered.

### S6. Anti-Combo Absence (0-5)

Test combinations of the player's abilities, items, or systems. Check:
- Do the player's tools work together, or do they interfere with each other?
- Are there combinations where using ability A makes ability B worse or impossible?
- Does the game force the player to choose between tools not because of strategic trade-offs but because the tools mechanically undermine each other?

Score 0 if multiple player tools actively undermine each other — using one makes others worse in ways that aren't strategic trade-offs but design accidents. Score 2 if most combinations work but one or two ability interactions produce unintended negative synergies. Score 4 if every combination of player tools either works together constructively or involves a clear, intentional trade-off that the player can reason about.

### S7. Use Pattern Coherence (0-5)

Examine what the player must actually do to play optimally. Check:
- Does optimal play require the player to act in ways that contradict their role, strategy, or character identity?
- Must the player do counterintuitive things to succeed? (E.g., a healer who should spend most of their time attacking, a stealthy character who benefits most from direct confrontation.)
- Does the game reward behavior consistent with the player's chosen approach, or does it reward meta-gaming that breaks thematic coherence?

Score 0 if optimal play requires systematically acting against the implied role or strategy — the best way to play contradicts what the game tells you to do. Score 2 if most play patterns are coherent but one or two optimal strategies require counterintuitive behavior that clashes with the game's framing. Score 4 if the most effective way to play is also the most thematically coherent way to play — optimal behavior matches what the game's framing and role system imply you should be doing.
