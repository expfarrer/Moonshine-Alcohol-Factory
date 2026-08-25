# Moonshine Mod - Alcohol Factory — Build Status

Repo: https://github.com/expfarrer/Moonshine-Alcohol-Factory (local clone at
`~/_develop/Moonshine-Alcohol-Factory`, not under `~/Zomboid/mods/`). Already live on
Steam Workshop with real subscribers, played in **multiplayer** (must keep working in
MP, not just SP). Currently built entirely on legacy PZ scripting (`module Moonshine
{ item X {...} }` items/recipes/models, `ReplaceOnUse`/`ReplaceOnDeplete` item-swap
chains, not Build 42 entities).

**`~/Zomboid/mods/MoonshineSpikeTest/` is this mod's own Phase -1 validation spike
for the beta migration below, not a separate/unrelated mod.** The cross-mod roadmap's
`docs/addon-roadmap.md` Feature 9 previously framed it as an independent from-scratch
build ("finish `MoonshineSpikeTest` into the shipped mod") — that was stale/wrong and
was **reconciled 2026-07-26**: Feature 9 now summarizes the real plan below and links
here + to the two plan files, rather than duplicating an outdated framing.

**STRATEGIC PIVOT, 2026-08-19 — Track 2 (entity-based beta migration, below) is
DEPRIORITIZED, not deleted.** After Track 2 accumulated many sessions of cost
concentrated almost entirely in Build 42's entity/station system (sprite-row
collisions, `addWorkstationEntity` failing 100% of the time it was tried,
`DryingCraftLogic`/`CraftBench` rigidity, custom tile-atlas art, an unresolved
idle-processing container bug), the user asked for a from-scratch reassessment:
fastest path to a working B42 conversion, ignoring the entity work's sunk cost.
**Track 3 (`b42-fast-port` branch, new section near the bottom of this file) is now
the active approach** — keeps distill pots as portable items (no entities, no native
fluids at all), doing a minimal syntax-only port instead. Track 2's branch
(`beta-migration`, entity work now called `still-idle-processing`) is kept exactly as
it stood, uncommitted work intact, for possible later revival — read Track 2 below as
a historical/paused record, not the current plan.

## What it is
Craftable distilling chain: mash buckets (corn/potato) → ferment → distill pots
(Small/Medium/Large, wood/coal/filter/column upgrade path) → spirit → drinkable
moonshine, plus disinfectant (isopropyl), gasohol fuel, motor-oil cans, skill-teaching
magazines, and a Molotov cocktail variant. Real scale: ~69 items, ~140 recipe blocks,
~20 Lua callbacks.

## Branch state
- `main` — clean initial-import commit only (`08cb10d`). Don't push fixes here
  directly.
- `develop` — tracks `origin/develop`, stable-branch-targeted. All Phase 1-6 bugfix
  work happens here. Currently 12 commits ahead of `main` (`9ca31bc`..`cef1f08`).
- `beta-migration` (now `still-idle-processing` for its entity-track content) —
  created 2026-07-29 off `develop`, worktree at `MoonshineModbf42/`. **Deprioritized
  2026-08-19** — see the pivot note above. Uncommitted content-track work is intact,
  kept for possible later revival, not currently the active path.
- `b42-fast-port` — **created 2026-08-19, off `develop`** (deliberately NOT off
  `beta-migration` — a clean restart from the stable B41 bugfix baseline), worktree at
  `MoonshineModb42fast/`, pushed to `origin`. **This is the current active B42
  approach.** See "Track 3" near the end of this file for full status.

## Build 42 went stable — 2026-07-29
Build 42.20.0 was promoted to Steam's public/stable branch overnight 2026-07-28→29,
after ~1 year in unstable/beta. This machine's PZ install was switched from a pinned
beta branch (`"42.19"`) to `public` the same day and confirmed running real
`version=42.20.0`. Full findings + assessment: this repo's Claude project memory,
`project_b42_stable_release.md`.

**LighterZ MP risk RESOLVED, same day, confirmed empirically (not just inferred from
patch notes).** Ran the exact test the risk finding called for: a real dedicated
server + a genuine remote client (`skoda`, over an actual network connection) crafted
`SpikeFluidOnCreateTest` — a `craftRecipe` combining a `-fluid` input with an
`OnCreate` callback, the precise mechanism LighterZ's author documented as broken in
MP. Server log confirmed `OnCreate FIRED ... isServer=true`, and the crafted output
item was correctly delivered to the client's inventory — full end-to-end success, not
just the callback firing. **Phase 3 design can now proceed using
`craftRecipe`+`-fluid`+`OnCreate` as originally planned**, no longer gated on this
question. Full detail: `project_phase_minus1_spike.md`.

**Full entity-level MP sync RESOLVED too, same session, immediately after.** The
recipe test above only proved the mechanism in isolation (a plain item, not a real
station entity). Went further: placed and built the spike's `SpikeStill` entity as
`skoda` (real remote client), opened its native `fluid_separator`-adapted UI
(contents displayed correctly, zero custom Lua wiring needed), filled it, and
transferred fluid into a bottle — all successful, zero errors in the server log.
**This was the last major Phase -1 dark spot — Phase -1 is now functionally closed.**
The plan was re-derived accordingly in `~/.claude/plans/bubbly-doodling-diffie.md`
(new "Dark spots / uncertainties" section) — remaining before Phase 3 real content:
`MashingLogic` (now optional), custom-atlas `SpriteConfig` syntax (unconfirmed but
likely fine), `common/media/` folder necessity (unconfirmed), and actually producing
real entity art (pipeline known, work not started).

**Steam Workshop publishing strategy, decided 2026-07-29: same Workshop item, not a
new separate submission.** One `mod.info`/id, `42/` versioned-subfolder convention as
designed. Steam auto-pushes updates to all existing subscribers; which content
actually loads splits cleanly by the player's game build — B41 players' loader only
reads the root `mod.info` (the `42/` subfolder is invisible to it), B42 players' loader
prefers `42/`. No re-subscription or manual choice needed for anyone.

**Phase 0 ✅ DONE, same day, commit `afd6d9f` on `beta-migration`** (rollback point
tagged beforehand: `beta-migration-pre-phase0`). Added `MoonshineMod/42/mod.info` —
**same `id=MoonshineMod` as the root mod.info**, confirmed required via the spike
mod's own actual files (the plan's earlier "distinct id=" note was wrong, written
before that was verified) — plus `42/poster.png` and an empty `42/media/` tree. Live
checkpoint passed: symlinked the dev worktree into `~/Zomboid/mods/` on the dev Mac,
confirmed "Moonshine Mod - Alcohol factory" now appears and is selectable in the
Build 42 Mods menu. (PC client doesn't have this dev copy yet, only the spike mods —
transfer needed if PC-side testing of the real mod is wanted later.)

**Phase 1 ✅ DONE, same day, commit `d6b2da8` on `beta-migration`.** `Coal` item
retagged in `42/media/`: `ItemType = base:normal`, `Tags = base:isfirefuel`,
`FireFuelRatio = 0.5` (verified against real vanilla `Charcoal`'s own use of this
mechanism; `0.5` chosen specifically to preserve the mod's original burn duration
exactly, not just approximate it). `camping_fuel.lua` intentionally omitted from
`42/media/` — the native tag replaces it. **Live checkpoint passed**: lit a fire with
the mod's Coal in singleplayer on 42.20.0, confirmed it burns via the tag alone.
**Gap flagged for a later phase:** `MoonshineMolotov`/`MoonshineMolotovBig` (same
source file, legacy `Type = Weapon`) weren't migrated — not in Phase 1's scope and
not assigned to any other phase in the plan either; needs a decision before Phase 5.

**Phase 2 ✅ DONE, same day, commit `8aafa12` on `beta-migration`.** Declared two
custom fluids in `42/media/scripts/fluids/MoonshineMod_Fluids.txt`: `Moonshine`
(drinkable spirit) and `MotorOil` (**no vanilla equivalent exists at all** — a gap
the original plan's taxonomy guess missed). `Water`/`RubbingAlcohol`/`Petrol` reused
as-is from vanilla. **Live checkpoint passed** — clean server boot, zero fluid-parse
errors. **Dev gotcha found+fixed:** a symlinked `~/Zomboid/mods/MoonshineMod` caused
two non-fatal `NullPointerException`s during server-boot checksumming; switched to a
real directory copy and they disappeared. Re-`cp -R` from the worktree after future
edits, don't re-symlink, until this gets root-caused further. **Next concrete step:
Phase 3 — core still rebuild, Small tier first.**

---

## Track 1: Stable-branch bugfix pass — Phases 1-5 done (2026-07-17/18)

1. Repo wasn't version-controlled before this — initialized git, pushed `main` +
   `develop` to GitHub.
2. Full audit (items/recipes/Lua/models/textures/translations) found ~12 confirmed
   bugs, fixed on `develop` in 12 commits, one per bug, phased lowest-risk-first.
   Highlights: two magazine items showing the wrong cover art (off-by-one
   `StaticModel` refs), a disassemble recipe silently not returning parts (dropped
   `OnCreate:` key), two permanently-uncraftable Molotov recipes (typo'd item names),
   two disinfectant items returning the wrong empty-bottle type.
3. Correlated remaining open questions against the stable-branch PZ install (buildid
   `22695648`) — resolved a "typo or real vanilla icon" question (real, confirmed),
   and identified a concrete merge-pattern fix for `camping_fuel.lua`'s global-table
   overwrite (superseded — see Track 2, beta deprecates this approach entirely).
4. Found the mod's live Steam Workshop deployment on this machine
   (`.../steamapps/workshop/content/108600/2983735259/mods/MoonshineMod/`).

**Future to-dos — Phase 6 (planned, not started):**
- 2 more missing tooltip translation keys, different naming convention from the ones
  already fixed (`Tooltip_Disinfectant` — 6 items, `Tooltip_Jar` — `EmptyJar`).
- Uncertain recipe: 2nd "Make Moonshiners Molotov Cocktail" variant may let players
  duplicate a bottle (missing `destroy` keyword vs. sibling recipes) — needs live-game
  verification before fixing, not just a static read.
- Dead-code cleanup: 2 unused functions in `MoonshineMod_giveskill.lua`.
- Apply the `camping_fuel.lua` merge-pattern fix — **low priority now**, since Track 2
  deprecates `camping_fuel.lua` entirely in favor of native `IsFireFuel` tags; only
  worth doing if stable-branch support continues independently for a while.
- Delete 3 unused leftover texture files (`CanOfOats - Copy.png`, `CanOfOats.png`,
  `Item_MoonshiningBook.png`).
- Idea, not scoped: compare the live Workshop deployment against `develop` to check
  drift.
- Idea, not scoped: diff vanilla `scripts/`+`lua/` stable-vs-beta (snapshots already
  exist, see Track 2) to see what else changed that could affect the mod.

Full detail with exact file/line references: `~/.claude/plans/radiant-humming-music.md`.

---

## Track 2: Beta/Build-42 migration — in progress, Phase -1 spike (2026-07-18 → present)

User switched this machine's PZ install to beta (buildid `23504596`) with the
explicit goal of building the "most finished" version of this mod for whenever beta
becomes the new stable — anticipating legacy scripting may not be supported forever,
so this track commits fully to native systems rather than hedging. Full plan:
`~/.claude/plans/bubbly-doodling-diffie.md`.

**Decisions already made (do not re-litigate):**
- Distill pots become stationary, world-placed station entities (all 3 tiers), not
  portable items.
- Full commitment to `craftRecipe`/`entity`/`fluid` syntax, no legacy fallback
  anywhere.
- Must work in MP (mod is actively used in MP today) — not just SP.
- New `beta-migration` branch off `develop`, intentionally breaking save/item-ID
  compat with the stable track.
- A disposable spike mod (`MoonshineSpikeTest`, NOT part of this repo, safe to delete
  once Phase -1 fully closes out) validates the architecture live before real content
  work starts.

**Resolved findings** (full detail: `project_phase_minus1_spike.md` in this repo's
Claude project memory — long, technical, several corrected-after-further-testing
entries, read directly rather than relying on this summary for specifics):
- Native `FluidContainer` + a `fluid_separator`-adapted `xuiSkin` gives working
  fill/transfer UI for free — no custom Lua needed for basic fill/pour.
- `craftRecipe` CAN produce fluid output (`+fluid` inside `inputs{}`) — resolved the
  single biggest open mechanism question.
- Legacy `Type = X` → `ItemType = base:x` is a mandatory field rename across the
  ENTIRE mod, not just the fluid-conversion families.
- Build 42 requires a versioned `42/` mod subfolder — flat legacy structure is
  silently invisible to the loader.
- `xuiSkin` blocks must be `module Base`, never a mod's own module — everything else
  (items/fluids/entities/craftRecipes) is fine mod-namespaced.
- SpriteConfig sprite-row picking: use an unclaimed row *inside* the real populated
  atlas range, not a wild guess or a claimed vanilla row (either mis-step breaks
  differently — hard crash vs. silent no-render).
- Confirmed (not assumed): the mod's existing `.fbx` ground models CANNOT be reused
  for entity visuals — genuine new 2D tile-atlas art is a real, unavoidable
  production requirement.
- A long-blocking item-creation crash (`NullPointerException` on `setAlcoholPower`)
  was actually a dedicated-server config gotcha — the server has its own separate
  `Mods=`/`WorkshopItems=` list, independent of the client's — not a script bug. New
  standing checklist item for ALL future MP/coop testing on this mod: check the
  server's own `Mods=` config first when client and server-side behavior diverge.
- Entity tier-transform (Small→Medium→Large): `WaterDispenser`'s entity-swap pattern
  is a confirmed-working precedent, no further spiking planned for this specific
  question.

**Dark spots — remaining before Phase 3 content work starts:**
- ~~MP validation of `craftRecipe`+`-fluid`+`OnCreate` / the LighterZ risk~~ —
  **RESOLVED 2026-07-29**, see above. Two more things confirmed the same MP-test
  session, worth folding into Phase 0 when it starts: (1) the 42.20 Steam update
  rewrote `StartServer.command`/`StartServerSteam.command` to add
  `--enable-native-access=ALL-UNNAMED` and
  `--add-exports=java.base/jdk.internal.misc=ALL-UNNAMED` JVM flags; (2) the dedicated
  server's boot log now probes for an optional `<mod>/common/media/AnimSets` folder
  alongside the existing `42/media/` one — not yet confirmed whether anything this mod
  actually needs lives there, or if it's unrelated optional infrastructure. Broader MP
  sync of the full entity/UI/`FluidContainer` stack (once the still is actually built)
  is still untested — only the specific recipe mechanism above is confirmed so far.
- **`MashingLogic` (native `Resources`+processing-`Logic` system) fluid-side
  viability is completely unconfirmed** — a possible better fit than plain
  `craftRecipe` for the mash→spirit transform, real vanilla precedent exists for the
  item-only case (`DryingCraftLogic`/Drying Rack), but ZERO vanilla entity anywhere
  uses `MashingLogic` or `Fluid@` resources — purely inferred from bytecode. Needs
  its own dedicated prototype before Phase 3 design relies on it.
- Whether the `fluid_separator`-adapted skin's fluid slot panel auto-populates
  natively or needs explicit Lua wiring — no vanilla entity uses this skin to check
  against.

**Future to-dos (after Phase -1 closes):** Phase 0 (branch + `42/` subfolder
scaffolding) → Phase 1 (camping fuel → `IsFireFuel` tag) → Phase 2 (fluid
declarations) → Phase 3 (still rebuild per tier, Small→Medium→Large, SP+MP
checkpoint per tier — the central, highest-risk phase) → Phase 4 (Disinfectant/
Drink/Petro bottle-item families) → Phase 5 (Lua cleanup, incl. an unrelated
pre-existing latent bug: an orphaned `Events.OnTick.Add(Tick)` call in
`MoonshineMod_recipecode.lua` with no `Tick` function defined anywhere — confirm
with user before touching, not part of the migration itself). ~20-22 commits total.

Stable-vs-beta snapshot diffs already captured at `~/Documents/pz-backups/` for
future re-diffing without needing to re-switch branches.

## Phase 3 findings — 2026-07-30

**Live-spike-confirmed: `craftRecipe`+`OnCreate` cannot reach a station entity's own
`FluidContainer`.** Built a diagnostic probe recipe/callback on the spike's
`SpikeStill` entity and tested it live (singleplayer) through several real failure
cycles. Findings: (1) entity/`CraftBench` `craftRecipe` inputs need an **explicit
`mode:` modifier** on every item or the action stalls at 0% forever (confirmed fix,
matches real vanilla `ExtractIronFromIronOre`'s pattern) — new standing rule for all
future entity recipes; (2) once firing, `OnCreate` only ever receives
`(recipeData, character)` — reflection on `recipeData`'s real Java class
(`CraftRecipeData`, extracted directly from the compiled jar) confirmed it has no
method that returns the workstation entity. **This is empirically closed, not
theorized** — mash→spirit cannot be a `craftRecipe`.

**Separately, ground-truth research into the real legacy mod** (bucket→ferment→mash→
distill flow, per the user's own description) found the original mash→spirit step is
plain **vanilla item-cooking** (`IsCookable`/`ReplaceOnCooked`, real heat source
required, ~950 in-game minutes for Small) — entities don't inherit this pipeline at
all.

**RESOLVED same day — real working mechanism found and confirmed live, not fluid at
all.** Tried `FurnaceLogic`+`Resources`(`Fluid@` groups) first; confirmed dead end by
extracting the recipe input parser (`InputScript.class`) directly from the compiled
jar — its fluid handling is entirely item-`FluidContainer`-based, no syntax exists
for a `craftRecipe` to address a named `Resources` `Fluid@` group at all. Pivoted to
keeping mash/spirit as **items** (matching the original mod's own item-to-item design
anyway) via `Resources`(`Item@` groups)+`DryingCraftLogic`+a plain tagged
`craftRecipe`, copying real vanilla `DryCorn`'s exact syntax verbatim. **Built
`SpikeDistiller` in the spike mod and confirmed live: built the entity, item-slot UI
(not fluid), dropped an item in, the timed process ran and completed, output item
appeared — full loop, zero errors.** This is now the confirmed mechanism for Phase 3's
mash→spirit step (Small tier, and by extension Medium/Large).

**APPLIED TO THE REAL MOD AND CONFIRMED LIVE, same day** (commits `da71c01`/
`368c9a5`/`d9636e4` on `beta-migration`). `DistillStillSmall` now has real
`Resources`+`DryingCraftLogic` producing a new `SpiritJarSmall` item from 10x
fermented mash over 950 real in-game minutes, matching the original exactly. Removed
the entity's unused `component FluidContainer` from commit 1 (not needed for this
mechanism). **Two real bugs hit and fixed, both broader than this one feature:**
(1) legacy `Type=` items crash the entity's item-slot UI on open, not just item
creation — ported `CornMashFermented`/`PotatoMashFermented` to `ItemType=base:food`;
(2) Build 42 doesn't fall back to legacy media for **any** file type, not just
scripts — a broken icon led to duplicating the mod's entire `textures/`+`models_X/`
wholesale into `42/media/` rather than hitting this per-asset later. Full detail:
`project_phase_minus1_spike.md`.

**Phase 3 commit 3/3 ✅ DONE, commit `ae00cc4` on `beta-migration`.** Ported
`MoonshineMod_recipecode.lua` to `42/media/lua/server/`, dropping the four
Small-tier-specific `OnCreate` callbacks now permanently dead in this track
(`GiveDistillPartsSm`, `GiveWoodSmall`, `GiveCoalSmall` — all tied to the old
portable `DistillPotSmall` item, replaced by the entity with no equivalent
salvage/fuel-container mechanic; `DoubbleFilledReturn` — already dead/commented-out
in the legacy mod itself). Everything else (Medium/Large/Filter/Column callbacks,
Petro family, Molotov check, `CheckDrumXD`) kept verbatim for the not-yet-migrated
tiers/families. Root/legacy file untouched. **Small tier's core mechanism (build,
fill, cook, output) confirmed live end-to-end, zero errors, zero custom Lua needed.**
Also confirmed: the earlier `ISItemSlot.lua:157` crash (empty-slot preview icon,
intermittent B42 load race — see the finding above) only affects an *empty* input
slot; once mash is inserted and cooking is active, it doesn't recur.

**Next concrete step: full SP+MP live checkpoint gate for the Small tier, then
Medium/Large.**

**Found same day, WRONGLY diagnosed, then corrected (commits `a64ebb1` →
superseding fix):** the mash-bucket item family's ground models rendered as flat
icons instead of 3D models in-world. First diagnosis (`a64ebb1`) claimed the
referenced `.fbx` files "don't exist anywhere, a pre-existing gap, same class as the
`MotorOilCanister_Ground3/4` stopgap" and repointed `StaticModel`/`WorldStaticModel`
straight to `BucketFull` — **this was wrong and didn't fully fix it** (user reported
"still shows icon not 3d" after retesting). Real root cause: Build 42's "no fallback
to legacy media" rule applies to an indirection layer too — the ORIGINAL
`StaticModel`/`WorldStaticModel` names (`BucketMash_GroundCorn_Fermented` etc.) were
always correct, but they're not direct filenames, they're names resolved via
`model X { mesh=..., texture=..., scale=... }` blocks in the legacy root
`MoonshineMod_Models.txt`, which was simply never ported into `42/`. Fixed by
reverting both items' `StaticModel`/`WorldStaticModel` back to the original names and
adding `42/media/scripts/MoonshineMod_Models.txt` with the two needed `model` blocks
(mesh=`BucketFull`, texture=`WorldItems/BucketFullMashFermented`, scale=`0.4`).
**Confirmed live by the user: model now renders correctly.** `.fbx` portable-item
models are confirmed NOT being phased out in Build 42 — vanilla's own brand-new
`FluidContainer` drink items still use `StaticModel`/`WorldStaticModel` extensively
(223 references across just `drainable.txt`'s 150 items). The other 6 un-ported
mash-bucket states will need the same `model`-block treatment whenever they're added
to `42/` in a later phase.

**New bug found same day, root-caused, NOT yet fixed — intermittent Build 42
script-load race on self-referencing mod recipes.** Opening the still's own crafting
UI sometimes (not always) spams `IndexOutOfBoundsException` at `ISItemSlot.lua:157`
every rendered frame (the right-corner error counter climbing rapidly), for the rest
of that world session. Root cause confirmed directly from the client debug log: on
some game-session loads (3 of 6 checked), `InputScript.OnPostWorldDictionaryInit`
logs `item not found: Moonshine.CornMashFermented` / `...PotatoMashFermented` while
validating the two `DistillCornMashIntoSpiritSmall`/`DistillPotatoMashIntoSpiritSmall`
craftRecipes — even though those items are real, load fine, and work correctly in
actual crafting/inventory during the very same session. This is a genuine
**intermittent load-order race**, not a script mistake: our craftRecipe (in
`generated/entities/moonshine/craftRecipes/`) and the items it references
(`items/MoonshineMod_AlcoholOutputItems.txt`) are in the *same mod*, so — unlike
vanilla's `DryCorn` referencing `Base.Corn`, where vanilla `Base.*` items are
guaranteed pre-loaded before any mod content parses — there's no ordering guarantee
between a mod's own items and its own entity-linked recipes, and B42's
parallelized script loading sometimes parses the recipe before the item is
registered. Once that race is lost for a session, the UI's item-slot preview
(`ISWidgetCraftLogicInputControl` → `InputScript:getPossibleInputItems()`) is left
with a permanently-empty resolved-items list, crashing every frame the empty slot
renders, until the world is fully reloaded (not fixed by `/reloadlua` hot-reloads,
which don't re-run `OnPostWorldDictionaryInit`). Immediate workaround: fully exit to
the main menu and reload the world/save. **Not yet permanently fixed** — needs
either a validated code-level mitigation (e.g. resolving the recipe input via
`tags[]` instead of a direct `[Module.Item]` bracket reference, unconfirmed whether
that avoids the race) or acceptance that this is a current B42 engine limitation to
track and re-test on future B42 point releases.

## Full mod audit + major finding — 2026-08-02

Ran a full audit comparing everything in the legacy mod against what's ported to
`42/` (user wanted the full remaining gap list in one pass instead of finding
things one at a time). Full categorized punch list in `project_phase_minus1_spike.md`
memory; headline items: `Moonshine_Distributions.lua` (loot-table spawning) was
never ported — likely why no magazines were findable in-world at all even once
items existed; Motor Oil + Molotov families are self-contained and portable;
Drink/Disinfectant/Petro recipe files (1165/820/674+95 lines) are built entirely
around the old portable-pot item-swap pattern the native `FluidContainer` system
replaces, so they need a redesign pass, not a literal port; Medium/Large distill
tiers are the single largest remaining piece of real work (two more entities,
same effort as Small tier).

**Then found something bigger while porting the mash-bucket upstream chain
(mix → cover → ferment) to close the "no magazines" gap directly reported by the
user: legacy lowercase `recipe {}` blocks are DEAD in Build 42.** Ported the 4
mash-chain hand-craft recipes as a literal copy of the legacy syntax (same
approach used successfully everywhere else so far) — every single field in every
recipe failed to parse (`Recipe.Load > Could not assign [key]: ...`, confirmed via
the live client log, not intermittent — 100% failure). Root cause: grepped all of
vanilla B42's scripts for lowercase `recipe` blocks — **zero hits anywhere**,
100% moved to `craftRecipe`. Fixed by rewriting all 4 as real `craftRecipe`s
(commit `e417675` on `beta-migration`) — required removing spaces from recipe
names (`craftRecipe` names must be single tokens), converting `Water=5,` to
`-fluid 5.0 [Water],`, tool/ingredient alternates to real vanilla tags
(`base:mixingutensil`, `base:sugar`), and `NeedToBeLearn`/`xpAward`/`SkillRequired`
to their `craftRecipe`-syntax equivalents. **This invalidates the "simple port"
classification from the same day's audit for almost everything left in the
mod** — Molotov, Disinfectant, Drink, Petro, Medium/Large distill, and Charcoal
recipes all use the same dead `recipe{}` syntax and will all need this same
rewrite treatment, not a literal copy, when their turn comes.

**Follow-up fix same feature, 2026-08-03: `-fluid` needs `mode:mixture` when its
source container is `mode:destroy`.** User reported a filled water bucket still
couldn't satisfy the mash recipe's water requirement. Root cause: `-fluid 5.0
[Water],` alone only works when the preceding item is `mode:keep` (draining a
kept container, e.g. `MakeMilkFromPowderBottle`); when the container is
`mode:destroy` (our case — the bucket becomes the mash), the fluid line also
needs `mode:mixture`, confirmed via real vanilla `recipes_buckets.txt` doing the
exact same "destroy a bucket, drain its water" pattern. Fixed
(`-fluid 5.0 categories[Water] mode:mixture,`), confirmed by the user after a
full world reload.

## Audit category A ported, Medium tier core started — 2026-08-03

Per user direction ("copy all items over", then "concentrate on base moonshine
items first, Molotov is a second tier item"), worked through the 2026-08-02
audit's category A (self-contained, no entity dependency) items, then started
Medium tier:
- `Moonshine_Distributions.lua` (787 lines, loot-table spawning) — wholesale
  ported, likely the actual reason no magazines were ever findable via normal
  exploration.
- Motor Oil family (9 items) — ported, `ItemType` renamed, model-indirection
  blocks added. Their crafting recipe is Petro-family work, not done yet.
- Molotov items (2) — ported, reuse vanilla's own `Molotov.png` icon directly.
  **Recipes intentionally NOT ported** — found real complications: the legacy
  `OnTest.FullLiquor`/`FullPetrolBottle` validators are undefined anywhere
  (Lua or compiled engine), a pre-existing bug in the original mod; `WineEmpty`/
  `WhiskeyEmpty` don't exist as separate items under B42's native fluid model;
  2 of 4 recipe variants depend on unported Petro items. Tracked as its own
  follow-up, not urgent per user (Molotov is "second tier").
- Tooltip translation files (4 languages) — wholesale ported, cosmetic only.
- **Medium tier core**: `DistillStillMedium` entity + mash→spirit, exact same
  pattern as the confirmed-working Small tier (`Resources`+`DryingCraftLogic`+
  two tagged `craftRecipe`s, new `SpiritJarMedium` output item, fresh unclaimed
  sprite placeholder row). **Deliberate scope simplification, flagged for
  follow-up:** given its own standalone build `CraftRecipe` rather than being
  reachable only via an "Upgrade Distill(I)to(II)" entity-swap from a built
  Small still, which is how the legacy design actually works (matching the
  `WaterDispenser` entity-swap precedent, not yet prototyped in this
  migration). Isopropyl (a second cook-again pass on an already-spirit-filled
  pot in the original design, not just a different input), Filter/Column
  attachment items, and Medium-tier charcoal recipes are real remaining scope,
  not oversights — tracked in the plan.

**Large tier core also built same day** (commit `aad04a4`) — identical pattern,
`DistillStillLarge` entity + mash→spirit, `SpiritJarLarge` output, `time=33000s`
(550 min matching the legacy `MinutesToCook` exactly). Same standalone-build
simplification and same real-remaining-scope caveats (Petrol stage, Filter/
Column attachments, Large-tier charcoal, upgrade-from-Medium) as Medium.

**Hard bug hit + fixed same day: sprite-row collision with the still-enabled
`MoonshineSpikeTest` mod, not just vanilla/this-mod's-own scripts.**
`DistillStillMedium` picked `crafted_01_47/48`, already claimed by
`MoonshineSpikeTest`'s own `SpikeDistiller` entity — caused a hard
`WorldDictionaryException` at world load, **the save wouldn't load at all**.
Fixed by moving to `crafted_01_51/52` (commit `8e8e4ba`) after re-grepping
claimed rows across vanilla + this mod + `MoonshineSpikeTest` together. New
standing rule, memory updated: any future sprite-row pick must check the spike
mod too, not just vanilla + this repo's own scripts.

**✅ Small tier live checkpoint gate PASSED, full loop, user-confirmed
2026-08-03: "ran the e2e - make mash - fermented - added to still 1 - made
moonshine."** Mix ingredients → cover with tarp → ferment (real `DaysFresh=4`/
`DaysTotallyRotten=12`, confirmed working after fixing a bad test edit —
`DaysFresh` requires an **integer**, a `0.01` test value threw
`InvalidParameterException` and hard-crashed script loading, fixed by using
integer test values instead) → distill in `DistillStillSmall` → drink real
`Moonshine` fluid. Zero errors, zero shortcuts (no debug-spawned intermediate
items) — this is the first fully player-reachable, no-cheats confirmation of
the whole rebuilt chain. This satisfies the plan's Phase 3 "critical gate"
requirement for Small tier's SP side; MP re-verification of the full chain
(not just the distill-recipe/entity-sync pieces already confirmed earlier)
is still open before calling Small tier fully done.

---

## Track 3: b42-fast-port — active B42 approach (2026-08-19 → present)

**Key insight that drove the pivot:** converting distill pots into world-placed
entities was always an optional design choice, not a B42 requirement. B41's pots are
portable `Moveable` items using vanilla's generic item-cooking pipeline
(`IsCookable`/`MinutesToCook`/`ReplaceOnCooked`/`ReplaceOnUse`) — nothing
entity-specific. Keeping them portable sidesteps every expensive failure mode found
in Track 2 (all entity-only): no tile art, no `addWorkstationEntity`, no
`CraftBench`/`DryingCraftLogic` quirks, no `FluidContainer` API landmines.

**Mechanical port done:** `Type=`→`ItemType=base:x` (~87 items), legacy `recipe{}`→
`craftRecipe{}` (95 converted; 96 originally dropped as "unfixable" — **this
diagnosis was wrong, corrected 2026-08-24, see below**), magazine
`TeachedRecipes=`→`LearnedRecipes=` conversion. Fatal-crash-class bugs found and
fixed: invalid `EvolvedRecipe` tokens (crashes at script load, not just a silent
dead-field), `time=` field float-vs-int `NumberFormatException`, `-fluid`
input-ordering requirement.

**Real recipe-design bugs found via a full 95-recipe input/output balance audit
(2026-08-22)** — a class of bug where a `craftRecipe` consumes a reusable vessel
(pot/jar/bottle/can) but never returns it empty, destroying it instead. Found and
fixed across ~30 recipes (spirit/water decant, disinfectant, petrol, 2 of 6 drum
recipes), plus a duplication regression self-caught and fixed the same session (two
recipes sharing one refund function with opposite correct behavior). **Two of these
turned out to be live bugs in the current shipping B41 Workshop version, not porting
artifacts** — backported to `develop` (bigger scope there: 68 decant recipes and all
6 drum recipes fixable, since B41 still has container items B42 vanilla later
removed).

**Confirmed live via real testing** on a working dedicated test server (`mvfast`):
Small+Medium tier mash→cover→heat→spirit→decant chain, fuel-interruption-mid-cook
safety, magazine-gated recipe unlocking, `CanBeDoneFromFloor` semantics (confirmed
additive against real B42 engine source, not floor-only).

**Still open, not yet done:** Medium/Large tier's full loop beyond decanting,
save/reload persistence mid-cook, real 2-player MP, several specific known bugs
(largest: `FillDistillIIIWithMotorOil` loses 32 empty cans per craft — **note: this
was actually fixed 2026-08-23 as part of the native-outputs conversion below**, this
line kept until re-confirmed live). All 9 `MinutesToCook` values are currently `1` for
testing (real values commented out above each) — must be reverted before release.

**2026-08-23/24 — MP sync-gap root fix, then full vessel-family coverage.** Found
that a burst of Lua `OnCreate` `AddItem()` calls (used by most refund/decant recipes)
has a real MP client-sync gap: server-side state is correct immediately, but the
client only sees the new items after a full reconnect, not a UI refresh. Root-fixed
(not just documented as a workaround) by converting every multi-item `OnCreate` burst
to native `outputs {}` blocks, which sync correctly. Same pass fixed a fatal
`Base.TreeBranch`→`Base.TreeBranch2` crash surfaced by the stricter validation native
outputs perform.

Then, **the "96 dropped, unfixable" diagnosis above was found to be wrong.** B42
didn't delete the Empty-item pattern — it renamed/collapsed several item families
into a single always-live ID (`Base.WhiskeyEmpty` doesn't exist, but `Base.Whiskey`
does; same for `Base.WineEmpty`→`Base.WineOpen`). Re-pointing `ReplaceOnUse`/
`ReplaceOnDeplete`/`Icon` at the correct current vanilla ID, then auditing every
vessel-input bracket against vanilla's real item family (Red Wine/Cheap Red
Wine/Aged Wine were missing from the Wine bracket; Imported Beer missing from Beer;
the entire Whiskey Bottle recipe family was missing from the port, not just
item-level bugs) restored full coverage. Extended to net-new vessel families (Soda,
Water Bottle, Sports Bottle, Bleach Bottle) across all 4 refill categories (Spirit,
Water, Disinfectant, Gasohol fuel-can), plus a new `DisinfectRagWithMoonshine
Disinfectant` recipe (mirrors vanilla's `DisinfectRag`). Confirmed live on `mvfast`
for Whiskey/Wine/Beer; full new-vessel batch deployed, not yet individually
re-confirmed per-vessel by the user. Full detail: this repo's Claude project memory,
`project_bottle_family_coverage_done.md`.

Full detail, chronological and exhaustive: this repo's Claude project memory —
`project_b42_fast_port.md` (findings log), `project_b42_fast_port_roadmap.md`
(done/open/feature-ideas/weak-points, the best single "state of the whole thing"
read), `project_b42_fast_port_test_checklist.md` (live-test queue),
`project_bottle_family_coverage_done.md` (this session's findings),
`reference_recipe_display_name_translation.md` (Recipes.json requirement for new
recipes).

---

## Related shared docs
- Stable-branch plan: `~/.claude/plans/radiant-humming-music.md`
- Beta-migration plan: `~/.claude/plans/bubbly-doodling-diffie.md`
- This repo's Claude project memory (`~/.claude/projects/-Users-tobias-conio--develop-Moonshine-Alcohol-Factory/memory/`) has the full, current, detailed record — this file is a summary, not a replacement.
- Cross-mod roadmap: `.../ProjectZomboid/docs/addon-roadmap.md` Feature 9 — reconciled 2026-07-26 to match this file.
