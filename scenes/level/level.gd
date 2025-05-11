class_name Level
extends Node

@onready var camera: Camera2D = $Camera2D;
@onready var tilemap: TileMapLayer = $Tilemap;
@onready var map_objects: Node2D = $MapObjects;
@onready var units: UnitTeamContainer = $Units;


func center_camera() -> void:
	var used_rect = tilemap.get_used_rect();
	var rect_center = used_rect.position + used_rect.size/2;
	var tile_size = tilemap.tile_set.tile_size;
	var tilemap_center = rect_center * tile_size;
	camera.global_position = tilemap_center;

func _ready() -> void:
	GameManager.setup_level(tilemap, map_objects , units);
	Navigation.setup_level(tilemap, units.get_units);
	center_camera();
