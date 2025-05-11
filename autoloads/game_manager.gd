extends Node

var tilemap: TileMapLayer;
var map_objects: Node2D;
var units: UnitTeamContainer;

func setup_level(
	_tilemap: TileMapLayer,
	_map_objects: Node2D,
	_units: UnitTeamContainer,
):
	tilemap = _tilemap;
	map_objects = _map_objects;
	units = _units;
