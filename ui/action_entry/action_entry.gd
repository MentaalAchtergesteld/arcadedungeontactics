class_name ActionEntry
extends PanelContainer

signal dropped(action: Action, tile_position: Vector2i);

@onready var action_name: Label = $ActionName;

var is_selected: bool = false;
var action: Action;
var origin: Vector2i;

var grid_position: Vector2i: get = calculate_grid_position;

func calculate_grid_position() -> Vector2i:
	var centralized_position = global_position + size/2;
	var world_position = Util.screen_to_world(centralized_position, GameManager.camera);
	return Navigation.world_to_map(world_position);

func update_action() -> void:
	if action == null: return;
	action_name.text = action.name();

func _ready() -> void:
	update_action();

var start_position: Vector2 = Vector2.ZERO;
var is_dragging: bool = false;

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return;
	
	if is_dragging:
		if !event.is_pressed():
			EventBus.clear_highlights.emit();
			is_dragging = false;
			if !action.get_tile_info(origin,grid_position).is_empty():
				dropped.emit(action, grid_position);
			global_position = start_position;
			
	elif event.is_pressed():
		is_dragging = true;
		start_position = global_position;

func _process(delta: float) -> void:
	if is_dragging:
		EventBus.clear_highlights.emit();
		EventBus.highlight_tiles.emit(action.get_tile_info(origin,grid_position));
		global_position = get_global_mouse_position() - size/2;

@warning_ignore("shadowed_variable")
const ACTION_ENTRY = preload("res://ui/action_entry/action_entry.tscn");
static func create(origin: Vector2i, action: Action) -> ActionEntry:
	var action_entry = ACTION_ENTRY.instantiate();
	action_entry.origin = origin;
	action_entry.action = action;
	return action_entry;
