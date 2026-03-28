# Test Prompts

Game concepts used for autoresearch iterations. The loop cycles through all concepts in randomized order.

Design principles for test prompts:
- **Short and open-ended** — give the AI freedom to pursue ambitious interpretations.
- **Varied genres and mechanics** — test different aspects of the criteria catalog.
- **Concrete enough to evaluate** — each specifies enough that "did it do what was asked?" is answerable.

---

## Prompt 1: Store Simulation

A store simulation game. Must have the ability to customize store layout, deal with customers, upgrade and modify the store over time, and hire employees for task automation.

---

## Prompt 2: Melee Combat Simulation

A turn-based melee simulation game. Must have simulations of grappling, wrestling, and a variety of different weapons. Must simulate body parts.

---

## Prompt 3: Space Station Infiltration

Space station infiltration game. You are an infiltrator on a space station in disguise. Your goal is to learn secrets, hack systems, sneak around, and maintain your cover, with the ultimate goal to destroy the space station. The station is random every time. Destruction is a success, escaping alive is a bonus.

---

## Prompt 4: Political Simulation

A political simulation game. The world contains a variety of interacting political systems, including nested systems (e.g., committees within legislatures within governments) and adjacent systems (e.g., media, courts, markets that influence politics). You are one political actor within one of these systems. Your goal is to gain influence for your faction. What success looks like depends on the system you're operating in.

---

## Prompt 5: Wilderness Survival Expedition

A wilderness survival expedition game. You lead a small party through a large, procedurally generated wilderness toward a distant objective. The environment is the primary antagonist — weather, terrain, wildlife, disease, and resource scarcity. Party members have individual skills, morale, and physical condition. The wilderness has varied biomes with different hazards and resources. Navigation, route planning, and resource management are core decisions. Reaching the objective is success; how many survive and in what condition is the measure of how well you did.

---

## Prompt 6: Gardening & Farm Simulation

A gardening/farm simulation game. Players manage plots of various kinds with an economy driven by demand for different plant products. Plant requirements — including environment, soil acidity, nutrient levels, water needs — should realistically vary by species. Upgrades include automation and employee hiring mechanics. The challenge is balancing crop diversity against specialization, managing soil health over time, and responding to market demand shifts.

---

## Prompt 7: Fishing Vessel Management

A fishing game centered on managing and upgrading a fishing vessel. Method, weather, location, season, and time of day should realistically affect both what is caught and the challenges players face traversing the ocean. The player should be able to scale from a dinky rowboat to a proper ocean-storm-ready vessel. Risk management — knowing when to push further out vs. when to head back — is a core tension.

---

## Prompt 8: Dynasty Strategy

A Paradox-style political strategy game where the player controls a country as a ruler. The player has control over deals, policy, state religion, military, and diplomacy. Evolving relationships, economy, war, and the state of the world can spell doom for your dynasty and power unless the player is competent to navigate these difficulties. Multiple AI-controlled nations operate autonomously with their own agendas.

---

## Prompt 9: Animal Survival

An animal simulation game. Play as one of several species, each with unique mechanics. The goal is to survive and reproduce, facing the natural challenges of nature — weather, hunger, perilous terrain, predators, competitors, and other animals both of the same species and not. Different species face fundamentally different decision spaces (a predator's decisions differ from prey's).

---

## Prompt 10: Sandbox Life Simulation

A sandbox life simulation game. The player can get one of several jobs, manage social relationships, pursue careers and hobbies. Different characters have different life goals, some competing with each other, some complementary. Success is self-defined — there is no single win condition. The simulation should model time passing, relationships evolving, career progression, and the tradeoffs between different life priorities.

---

## Coverage Analysis

Which criteria categories each prompt is likely to exercise:

| Category | Store | Melee | Infiltration | Political | Survival |
|----------|-------|-------|-------------|-----------|----------|
| A. Rules & Formal Structure | yes | yes | yes | yes | yes |
| B. Systems & Emergence | yes | yes | yes | yes | yes |
| C. World & Simulation | yes | partial | yes | yes | yes |
| D. Decision Architecture | yes | yes | yes | yes | yes |
| E. Information Design | yes | yes | yes | yes | yes |
| F. Uncertainty & Randomness | partial | yes | yes | yes | yes |
| G. Economy & Resource | yes | no | partial | partial | yes |
| H. Challenge & Difficulty | yes | yes | yes | yes | yes |
| I. Learning & Mastery | yes | yes | yes | yes | yes |
| J. Pacing & Rhythm | yes | yes | yes | yes | yes |
| K. Engagement & Compulsion | yes | yes | yes | yes | yes |
| L. Player Agency & Freedom | yes | partial | yes | yes | yes |
| M. Motivation & Reward | yes | yes | yes | yes | yes |
| N. Aesthetic & Thematic | yes | yes | yes | yes | yes |
| O. Balance & Stability | yes | yes | yes | yes | yes |
| P. Interface & Usability | yes | yes | yes | yes | yes |
| Q. AI & Opposition | yes | yes | yes | yes | partial |
| R. Variety & Replayability | partial | partial | yes | yes | yes |
| S. Completeness & Polish | yes | yes | yes | yes | yes |
| T. Goal Structure | yes | partial | yes | yes | yes |
| U. Specific Design Lenses | yes | yes | yes | yes | yes |

### Coverage notes

- **Melee (P2)** is intentionally narrow — tests whether a game can score well by being deep in one domain. Economy (G) and broad world sim (C) are mostly N/A.
- **Political (P4)** is the strongest test for world autonomy (C10), player de-centering (C13), AI personality (Q2), chain reactions (B5), and nested system interactions (B1/B9).
- **Survival (P5)** is the strongest test for environmental pressure (G4 pinch points), exploration/discovery (K2/K4/K12), environmental legibility (E17), failure generativity (H12), and knowledge-gated progression (I12).
- **Q (AI) is partial for Survival** — the environment is the primary antagonist, not AI agents. Wildlife/NPCs may have AI but it's not the core.
- Every category has at least 4/5 prompts exercising it. No category is untested.
