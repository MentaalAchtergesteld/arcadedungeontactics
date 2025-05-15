class_name DragComponent
extends Node

signal dropped(position: Vector2);
signal dragged(position: Vector2);
signal drag_started;

@export var drag_button := MOUSE_BUTTON_LEFT;

@export var actor: Control;
@export var button: MouseButton = MOUSE_BUTTON_LEFT;

var is_dragging: bool = false;
var start_position: Vector2 = Vector2.ZERO;

func handle_click(event: InputEventMouseButton) -> void:
	if event.is_pressed():
		if not is_dragging:
			is_dragging = true;
			start_position = actor.global_position;
	else:
		is_dragging = false;
		actor.global_position = start_position;
		dropped.emit(event.global_position);

func handle_movement(event: InputEventMouseMotion) -> void:
	if not (is_dragging): return;
	actor.global_position = event.global_position - actor.size/2;
	dragged.emit(event.global_position);
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		handle_click(event);
	elif event is InputEventMouseMotion:
		handle_movement(event);

func _ready() -> void:
	actor.gui_input.connect(_gui_input);
