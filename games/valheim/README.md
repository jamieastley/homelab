# Valheim

A modded Valheim server.

Game data such as world saves, mod configs, server data and save backups are all stored in their own
external Docker volumes and should be created before running `docker compose up`.

## Getting started

- create `adminlist.txt`, populate with [steamID64](https://steamid.io/) _on separate lines_ and place file in root of `valheim_saves` volume.
- Upload required mod configs to root of `valheim_mod_configs` volume
- ensure `init_permissions` container has been executed prior to (re)starting server container

## Mods to add

### Client-side only

- https://thunderstore.io/c/valheim/p/OdinPlus/QuickTeleport/
- https://thunderstore.io/c/valheim/p/Azumatt/CurrencyPocket/
- https://thunderstore.io/c/valheim/p/ComfyMods/SearsCatalog/
- https://thunderstore.io/c/valheim/p/Azumatt/Recipe_Description_Expansion/
- https://thunderstore.io/c/valheim/p/Azumatt/AzuHoverStats/
- https://thunderstore.io/c/valheim/p/TastyChickenLegs/RecyclePlus/
- https://thunderstore.io/c/valheim/p/Azumatt/Minimal_UI/
