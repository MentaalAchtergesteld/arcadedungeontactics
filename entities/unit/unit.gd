class_name Unit
extends Node2D

signal died;
signal turn_complete;

@onready var health_component: HealthComponent = $HealthComponent;
@onready var position_component: PositionComponent = $PositionComponent;

@export var controller: UnitController;
@export var definition: UnitDefinition;

var grid_position: Vector2i:
	get: return position_component.grid_position;

var alive: bool:
	get: return health_component.current_health > 0;

func _on_controller_finished():
	turn_complete.emit();

func start_turn():
	await get_tree().create_timer(0.5).timeout;
	controller.start(self, grid_position);

func _on_health_depleted():
	visible = false;
	died.emit();

func update_definition() -> void:
	if definition == null: return;
	name = definition.name;
	health_component.max_health = definition.max_health;

func _ready() -> void:
	health_component.health_depleted.connect(_on_health_depleted);
	controller.setup(definition.actions);
	controller.finished.connect(_on_controller_finished);
