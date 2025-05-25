class_name HoverComponent
extends Area2D

signal hover_entered;
signal hover_exited;

func _init() -> void:
	set_collision_layer_value(1, false);
	set_collision_mask_value(1, false);
	
	set_collision_layer_value(8, true);
	set_collision_mask_value(8, true);
	

func _ready() -> void:
	mouse_entered.connect(func(): hover_entered.emit());
	mouse_exited.connect(func(): hover_exited.emit());
