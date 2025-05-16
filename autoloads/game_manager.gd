extends Node

var game_speed = 0.5;

var tilemap: TileMapLayer;
var map_objects: Node2D;
var units: UnitTeamContainer;
var camera: Camera2D;

func setup_level(
	_tilemap: TileMapLayer,
	_map_objects: Node2D,
	_units: UnitTeamContainer,
	_camera: Camera2D,
):
	tilemap = _tilemap;
	map_objects = _map_objects;
	units = _units;
	camera = _camera;
