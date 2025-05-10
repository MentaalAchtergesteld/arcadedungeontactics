class_name Unit
extends Node2D

@onready var health_component: HealthComponent = $HealthComponent;
@onready var position_component: PositionComponent = $PositionComponent;

var grid_position: Vector2i:
	get: return position_component.grid_position;

var alive:
	get: health_component.current_health > 0;

func _on_tilemap_changed():
	global_position = Navigation.map_to_world(Vector2i(2, 5));

func _ready() -> void:
	Navigation.tilemap_changed.connect(_on_tilemap_changed);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		position_component.move_along_relative_path([
			Vector2i(0, 1),
			Vector2i(0, 1),
			Vector2i(0, 1),
			Vector2i(1, 0),
			Vector2i(1, 0),
			Vector2i(0, -1),
			Vector2i(-1, 0),
		])
