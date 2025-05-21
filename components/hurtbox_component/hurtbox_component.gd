class_name HurtboxComponent
extends Area2D

signal hurt(attacker: Node, effects: Array[EntityEffect]);

@export var actor: Node;
@export var enabled: bool = true:
	set(value):
		enabled = value;
		monitorable = enabled;
		monitoring = enabled;

func _on_area_entered(area: Area2D) -> void:
	if !enabled or not area is HitboxComponent: return;
	var hitbox = area as HitboxComponent;
	if hitbox.actor == actor: return;
	hurt.emit(hitbox.actor, hitbox.effects);

func _init() -> void:
	set_collision_layer_value(1, false);
	set_collision_layer_value(2, true);
	set_collision_mask_value(1, true);
	
	enabled = enabled;

func _ready() -> void:
	area_entered.connect(_on_area_entered);
