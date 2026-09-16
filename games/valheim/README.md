# Valheim

A modded Valheim server.

Game data such as world saves, mod configs, server data and save backups are all stored in their own
external Docker volumes and should be created before running `docker compose up`.

## Getting started

- create `adminlist.txt`, populate with [steamID64](https://steamid.io/) _on separate lines_ and place file in root of `saves` volume.
- ensure `init-permissions` container has been executed prior to (re)starting server container

## Mods to add

### Client-side only

- https://valheim.hexium.gg/mods/Azumatt/ItemCompare
- https://valheim.hexium.gg/mods/Azumatt/AzuHoverStats
- https://valheim.hexium.gg/mods/Azumatt/ChangeOfScenery
- https://valheim.hexium.gg/mods/Azumatt/CurrencyPocket
- https://valheim.hexium.gg/mods/Azumatt/Minimal_UI
- https://valheim.hexium.gg/mods/Azumatt/TooltipExpansion
- https://valheim.hexium.gg/mods/Azumatt/Recipe_Description_Expansion
