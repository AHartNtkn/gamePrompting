# Category V: Visual Representation & ASCII Graphics

You are evaluating how effectively the game uses visual elements — ASCII art, diagrams, maps, gauges, charts, and other non-prose representations — to enhance player comprehension and experience. This category evaluates both the presence of visual representation where it's needed and the quality of visual representation where it exists.

## Criteria and Evaluation Instructions

### V1. Spatial Representation Appropriateness (0-5)

Identify every element of the game that involves spatial relationships (position, adjacency, layout, distance, line of sight, paths). Check:
- Does the game provide a visual map, grid, or diagram for spatial information?
- Or does it describe spatial relationships only in text ("the exit is to the north, the guard is near the door")?
- For each spatial element, would a visual display help the player make spatial decisions?

Score 0 if the game involves significant spatial reasoning (navigation, positioning, layout) but provides no visual spatial display at all. Score 2 if some spatial information is visualized but key spatial elements remain text-only. Score 4 if all spatial relationships that affect gameplay decisions are presented visually in a clear, usable display.

### V2. Quantity Visualization (0-5) `[CONDITIONAL: game has quantities the player monitors]`

Identify every quantity the player must track or compare during play (health, resources, progress, morale, time, scores). Check:
- Are these shown as visual gauges (bars, meters, proportional fills) in addition to or instead of raw numbers?
- Can the player assess relative levels at a glance, or must they read and compare numbers?
- Is urgency communicated visually (a nearly-empty bar reads as danger faster than "HP: 12/100")?

Score 0 if all quantities are displayed as raw numbers only with no visual representation. Score 2 if some quantities have visual gauges but important ones are numbers-only. Score 4 if all player-monitored quantities have visual representation that communicates magnitude and urgency at a glance.

### V3. Entity Visual Identity (0-5) `[CONDITIONAL: game has entities whose individual identity matters]`

When the game has named characters, unique opponents, specific items, or distinct factions, check:
- Do individual entities have any visual differentiation beyond their text name/description?
- Can the player recognize a returning entity visually, or only by reading its name?
- For factions or categories, is there visual identity (heraldry, color coding, distinct symbols)?

Score 0 if entities with meaningful individual identity have no visual representation — they are only distinguished by text labels. Score 2 if some visual differentiation exists but it's minimal (e.g., a single icon per entity type, no individual variation). Score 4 if entities have rich visual identity — procedural portraits, distinct visual profiles, faction heraldry — that makes individuals recognizable and memorable.

### V4. Structural Diagramming (0-5) `[CONDITIONAL: game has structures with meaningful layout]`

When the game involves objects or systems with meaningful internal arrangement (vehicle components, building floor plans, body parts, network topology, mechanical assemblies, organizational hierarchies), check:
- Are these structures depicted visually (diagrams, cross-sections, schematics)?
- Or are they described only in text ("the engine is under the hood, the alternator is connected to the engine")?
- Does the visual representation help the player understand relationships between components?

Score 0 if the game has structures with meaningful layout but provides no diagrams — all structural information is textual. Score 2 if some structures are diagrammed but others that would benefit from visualization are text-only. Score 4 if all structures with meaningful spatial arrangement are depicted visually with clear component relationships.

### V5. Visual Representation Absence (0-5)

Review the game holistically for missed opportunities. Check:
- Are there game elements that would obviously benefit from a visual display but have none? (A map for navigation, a graph for trends, a diagram for a mechanism, a gauge for a critical resource)
- Would a player looking at this game say "why can't I see this?"
- Compare what the game concept implies (spatial navigation, physical layout, body targeting, network topology) against what the game actually displays visually.

Score 0 if the game is almost entirely text-menu-based despite the concept strongly implying spatial, structural, or comparative visual needs — multiple obvious opportunities for visual representation are missed. Score 2 if some visual elements exist but notable gaps remain. Score 4 if the game has identified and addressed all obvious opportunities for visual representation — no player would look at the output and think "this needs a picture."

### V6. Symbol Consistency (0-5) `[CONDITIONAL: game uses ASCII symbols for game elements]`

Examine every symbol used in visual displays. Check:
- Does each symbol have one consistent meaning, or are symbols reused for unrelated things?
- Can the player learn the visual vocabulary and apply it reliably?
- Is there a legend or are meanings discoverable through context?

Score 0 if symbols have contradictory or confusing meanings — the same character represents different things with no way to distinguish context. Score 2 if most symbols are consistent but a few are overloaded or ambiguous. Score 4 if the visual vocabulary is fully consistent and learnable — each symbol has one meaning and the player can decode any display after learning the vocabulary.

### V7. Visual Readability (0-5) `[CONDITIONAL: game has visual displays]`

Examine each visual display the game produces. Check:
- Can the player extract key information within 2-3 seconds of looking?
- Is there clear figure/ground separation — important elements stand out from background?
- Does the display use negative space (empty areas, spacing) to make important elements prominent?
- Or is the display a dense wall of characters where nothing stands out?

Score 0 if visual displays are dense and unreadable — information is technically present but extracting it requires careful character-by-character scanning. Score 2 if displays are somewhat readable but key information doesn't stand out clearly. Score 4 if displays are immediately scannable — the player's eye is drawn to what matters, with clear visual hierarchy and appropriate use of spacing.

### V8. Color Semantics (0-5) `[CONDITIONAL: game uses color]`

Examine how the game uses color. Check:
- Does color encode consistent gameplay-relevant categories (urgency, type, state, faction)?
- Is the color scheme systematic (red always means danger, green always means safe/healthy)?
- Or is color applied arbitrarily with no consistent meaning?

Score 0 if color is used randomly with no semantic consistency — colors are decorative rather than informative. Score 2 if some colors have consistent meaning but the scheme is incomplete or has exceptions. Score 4 if color consistently encodes gameplay-relevant information throughout the game — the player can interpret color as reliable signal.

### V9. Decorative vs. Functional Art (0-5) `[CONDITIONAL: game uses ASCII art]`

Examine every piece of ASCII art in the game. For each, identify what it communicates. Check:
- Does it convey identity, spatial relationship, status, structure, or atmosphere?
- Or is it purely decorative — occupying screen space without informing any decision?
- Do large art blocks (title screens, banners, illustrations) push useful information off-screen?

Score 0 if the game contains significant ASCII art that is purely decorative — large illustrations, ornamental borders, or banner art that communicates nothing the player needs. Score 2 if most art is functional but some decorative elements waste screen space. Score 4 if every piece of ASCII art earns its screen space by communicating something useful — and no art displaces functional information.

### V10. Dynamic Visual Updates (0-5) `[CONDITIONAL: game has visual representations of changing state]`

When visual elements represent things that change (maps, health bars, building states, damage, inventory), check:
- Does the visual update to reflect current state?
- Or does it remain static while the underlying data changes, becoming inaccurate?
- After a significant state change, does the visual display immediately reflect it?

Score 0 if visual representations are static snapshots that don't update as game state changes — the art becomes a lie. Score 2 if some visuals update but others become stale. Score 4 if all visual representations dynamically reflect current state — the player can trust that what they see is what is.

### V11. Art-Information Integration (0-5) `[CONDITIONAL: game uses ASCII art]`

Check how visual and textual information relate. Check:
- Does art appear alongside functional information (stats, options, descriptions) or instead of it?
- Are diagrams labeled? Do maps have legends if symbols are non-obvious?
- Does visual representation complement text, or does it substitute for information the player needs?

Score 0 if ASCII art displaces functional information — a portrait replaces stats, a map provides no legend, a diagram has no labels. Score 2 if art and information coexist but aren't well integrated. Score 4 if visual and textual information complement each other — art provides at-a-glance comprehension while adjacent text provides precision and detail.

### V12. Medium-Appropriate Abstraction (0-5) `[CONDITIONAL: game uses ASCII art]`

Examine the style of ASCII art used. Check:
- Does it use abstraction appropriate to text characters — semi-abstract line art that suggests form?
- Or does it attempt photorealistic detail that text characters can't deliver, producing visual noise?
- Would simpler, more abstract representations communicate more effectively?

Score 0 if ASCII art attempts detail beyond what text can render — 40-line realistic drawings that resolve into character noise. Score 2 if art style is inconsistent — some elements are well-abstracted, others over-detailed. Score 4 if the game uses a consistent level of abstraction that plays to the medium's strengths — suggesting form and letting the player's imagination complete the picture.
