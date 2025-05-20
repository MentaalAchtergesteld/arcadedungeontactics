# ✅ Vertical Slice Features – Turn-Based Chain-Reaction Game

[ ] Todo: Nog niet aan begonnen.
[/] Bezig: Er wordt actief aan gewerkt.
[*] Af voor nu: Het werkt nu, maar moet later nog verbeterd worden of uitgebreid worden.
[X] Af: Volledig geïmplementeerd en goed voor de final game.

## Core Gameplay
- [*] TileMap-grid met vaste tilegrootte
- [*] Speler kan acties kiezen en uitvoeren (beweging, aanval, ability)
- [ ] Vijanden met eenvoudige AI (bv. loop naar speler, ontplof bij dood)
- [*] Beurtensysteem (speler > vijanden > speler)

## Units & Interactie
- [/] HealthComponent en DamageSystem via composition
- [ ] Chain-reacties (bv. vijand explodeert > andere vijanden in vuur > extra reactie)
- [/] Abilities met simpele effecten (verplaatsing, explosie, stun)
- [ ] Perks of upgrades die acties beïnvloeden (passieve modifiers)

## Map & Spawning
- [X] Editor-based enemy/player placement via snap
- [ ] Dynamisch laden van kamers/levels
- [ ] Objecten zoals exploderende barrels

## UI
- [ ] HD UI met actieknoppen of kaartkeuzes
- [ ] Turn-indicator
- [*] Healthbars boven units

## Tech & Architectuur
- [/] Navigation singleton voor grid-aligning en pathfinding
- [/] GameManager singleton voor toegang tot UnitTeamContainer en dergelijke.
- [*] Unit-data via UnitDefinition (Resource)
- [*] Level scene met duidelijke hiërarchie: TileMap, Units, Objects, Effects
- [X] World renderen met Camera2D zoom (pixelart) + HD UI layer

## Polish (optioneel)
- [/] Eenvoudige hit-effecten of animaties
- [*] Highlighting van bereikbare tegels of doelen
