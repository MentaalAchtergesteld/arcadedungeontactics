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
	EventBus.clear_winner.emit();
	GameManager.setup_level(tilemap, map_objects ,units, camera);
	Navigation.setup_level(tilemap, units.get_units);
	center_camera();
	
	units.start_battle();

func _on_units_battle_over(winning_team: UnitTeam) -> void:
	EventBus.set_winner.emit(winning_team);
	print("Battle over! Winner: " + winning_team.name);

func _on_units_battle_draw() -> void:
	EventBus.set_winner_draw.emit();
	print("Battle draw!");
