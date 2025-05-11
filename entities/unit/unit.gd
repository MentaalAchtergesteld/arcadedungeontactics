class_name Unit
extends Node2D

signal died;
signal turn_complete;

@onready var health_component: HealthComponent = $HealthComponent;
@onready var position_component: PositionComponent = $PositionComponent;

var grid_position: Vector2i:
	get: return position_component.grid_position;

var alive: bool:
	get: return health_component.current_health > 0;

func start_turn():
	var action = AttackAction.new();
	var tiles = action.get_tile_info(self, grid_position);
	
	var enemy_position;
	for tile in tiles:
		if tile.role == TileInfo.RoleType.Clickable:
			enemy_position = tile.position;
			break;
	
	if enemy_position == null:
		print("No enemy found :(");
		return;
	action.execute(self, grid_position, enemy_position);
	
	await get_tree().create_timer(1).timeout;
	turn_complete.emit();

func _on_health_depleted():
	died.emit();

func _ready() -> void:
	health_component.health_depleted.connect(_on_health_depleted);
