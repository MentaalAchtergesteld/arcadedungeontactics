class_name HitboxComponent
extends Area2D

signal hit(victim: Node);

@export var actor: Node;
@export var effects: Array[EntityEffect];
@export var enabled: bool = true:
	set(value):
		enabled = value;
		set_deferred("monitorable", enabled);
		set_deferred("monitoring", enabled);

func _on_area_entered(area: Area2D) -> void:
	if not area is HurtboxComponent: return;
	var hurtbox = area as HurtboxComponent;
	if hurtbox.actor == actor: return;
	hit.emit(hurtbox);

func _init() -> void:
	set_collision_layer_value(2, true);
	set_collision_mask_value(1, false);
	set_collision_mask_value(2, true);
	
	enabled = enabled;

func _ready() -> void:
	area_entered.connect(_on_area_entered);
