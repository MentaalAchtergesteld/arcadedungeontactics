class_name ActionEntry
extends PanelContainer

signal dropped(action: Action, tile_position: Vector2i);
signal selected(action: Action);

@onready var action_name: Label = $ActionName;

var is_selected: bool = false;
var action: Action;

func update_action() -> void:
	if action == null: return;
	action_name.text = action.name();

func select() -> void:
	is_selected = true;
	selected.emit(action);
	scale = Vector2(1.5, 1.5);

func deselect() -> void:
	is_selected = false;
	scale = Vector2(1, 1);

func _on_button_pressed() -> void:
	if is_selected:
		deselect();
	else:
		select();

func _ready() -> void:
	update_action();

var start_position: Vector2 = Vector2.ZERO;
var is_dragging: bool = false;

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return;
	
	if is_dragging:
		if !event.is_pressed():
			is_dragging = false;
			var centralized_position = global_position + size/2;
			var world_position = Util.screen_to_world(centralized_position, GameManager.camera);
			dropped.emit(action, Navigation.world_to_map(world_position));
			global_position = start_position;
			
	elif event.is_pressed():
		is_dragging = true;
		start_position = global_position;

func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - size/2;

@warning_ignore("shadowed_variable")
const ACTION_ENTRY = preload("res://ui/action_entry/action_entry.tscn");
static func create(action: Action) -> ActionEntry:
	var action_entry = ACTION_ENTRY.instantiate();
	action_entry.action = action;
	return action_entry;
