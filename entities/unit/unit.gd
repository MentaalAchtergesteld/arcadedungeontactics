@tool
class_name Unit
extends Node2D

signal died;
signal turn_complete;

@onready var sprite: Sprite2D = $Sprite2D;
@onready var health_component: HealthComponent = $HealthComponent;
@onready var position_component: PositionComponent = $PositionComponent;

@export var controller: UnitController;
@export var definition: UnitDefinition:
	set(value):
		definition = value;
		if Engine.is_editor_hint(): update_definition();

var grid_position: Vector2i:
	get: return position_component.grid_position;

var alive: bool:
	get: return health_component.current_health > 0;

func select():
	$SelectedIndicator.visible = true;

func deselect():
	$SelectedIndicator.visible = false;

func start_turn():
	select();
	await get_tree().create_timer(0.5).timeout;
	controller.start(self, grid_position);
	await controller.finished;
	turn_complete.emit.call_deferred();
	deselect();

func _on_health_depleted():
	visible = false;
	died.emit();

func update_definition() -> void:
	if definition == null: return;
	name = definition.name;
	sprite.texture = definition.texture;
	health_component.max_health = definition.max_health;
	health_component.current_health = health_component.max_health;

func _ready() -> void:
	if !Engine.is_editor_hint():
		health_component.health_depleted.connect(_on_health_depleted);
		controller.setup(definition.actions);
	
	update_definition();
