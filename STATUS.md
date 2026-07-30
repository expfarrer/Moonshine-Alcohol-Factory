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
- `beta-migration` — **created 2026-07-29**, branched off `develop`, checked out as a
  git worktree at `MoonshineModbf42/` (sibling of the repo root, same `.git`/remote),
  pushed to `origin`. Zero content commits yet — mirrors `develop` exactly. Will
  intentionally break save/item-ID compatibility with the stable-targeted
  `develop`/`main` — a separate future version track, existing subscribers on stable
  stay unaffected.

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
mash→spirit step (Small tier, and by extension Medium/Large). Full detail:
`project_phase_minus1_spike.md`. **Next concrete step: apply this pattern to the real
mod's `DistillStillSmall` entity.**

---

## Related shared docs
- Stable-branch plan: `~/.claude/plans/radiant-humming-music.md`
- Beta-migration plan: `~/.claude/plans/bubbly-doodling-diffie.md`
- This repo's Claude project memory (`~/.claude/projects/-Users-tobias-conio--develop-Moonshine-Alcohol-Factory/memory/`) has the full, current, detailed record — this file is a summary, not a replacement.
- Cross-mod roadmap: `.../ProjectZomboid/docs/addon-roadmap.md` Feature 9 — reconciled 2026-07-26 to match this file.
