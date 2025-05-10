class_name Unit
extends Node2D

@onready var health_component: HealthComponent = $HealthComponent;

var cell_position: Vector2i:
	get: return Navigation.world_to_map(global_position);

var alive:
	get: health_component.current_health > 0;

func _on_tilemap_changed():
	global_position = Navigation.map_to_world(Vector2i(2, 5));

func _ready() -> void:
	Navigation.tilemap_changed.connect(_on_tilemap_changed);
