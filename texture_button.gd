extends Button

@export var action_data: Resource
signal drag_started(action_data)

var start_position: Vector2 = Vector2.ZERO;
var is_dragging: bool = false;

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return;
	
	if is_dragging:
		if !event.is_pressed():
			is_dragging = false;
			global_position = start_position;
	elif event.is_pressed():
		is_dragging = true;
		start_position = global_position;

func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - size/2;
