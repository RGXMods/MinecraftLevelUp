## v2.0.7 - 2026-11-05

- Fixed WoW Forever: the base TOC now declares Interface 16001, which is what the Forever client reads, so the addon loads as compatible instead of out of date.
- Removed the unused _Forever.toc file.
- TOC files no longer start with a byte-order mark.

# Non-beta Candidate: [v2.0.5](changelogs/2.0.5.md)

Retail 12.1.5 / Interface `120105`; client testing and publication pending.

# v2.0.4 - 2026-09-27

## Changes
- TOC set now covers every active WoW flavor: Retail 120100, Classic Era 11509, TBC 20506, Wrath 38002, Cataclysm 40402, Mists 50504, and WoW Forever 16001. The base TOC claims 120100,16001 so the Forever beta loads without the out-of-date flag.
- Added missing flavor TOCs: MinecraftLevelUp_Cata.toc, MinecraftLevelUp_Mists.toc, MinecraftLevelUp_Forever.toc.
- Aligned the version (2.0.4) across all TOCs and ADDON_VERSION in data/core.lua.

# v2.0.2 - 2026-06-30

## Changes

- Updated for WoW Retail 12.0.7 (Interface 120007).

# v2.0.0 - 2026-04-30

## Changes

- **Full architecture migration**: Restructured from legacy single-file to modern RGX-Framework architecture with `data/core.lua`, `data/locales.lua`, and `sounds/` directory.
- **Migrated to RGX-Framework**: Added `RequiredDeps: RGX-Framework` to TOC. Core logic now uses `RGX:GetSound()`, `RGX:RegisterEvent()`, and `RGX:RegisterSlashCommand()`.
- **Sound variants**: Added high/medium/low quality sound variants.
- **Localization**: Added multi-language support (enUS, deDE, frFR, esES, ruRU).
- **Settings**: Added persistent SavedVariables with slash commands for enable/disable, sound variant, and volume channel.
- **RGXSound handle**: Sound playback, variant management, mute/unmute, settings, and welcome message are now handled by the RGXSound module in RGX-Framework.
