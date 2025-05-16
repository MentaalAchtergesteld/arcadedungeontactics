class_name ActionEntry
extends PanelContainer

signal dropped(action: Action, tile_position: Vector2i);

@onready var action_name: Label = $ActionName;

var is_selected: bool = false;
var action: Action;
var origin: Vector2i;

func pos_to_grid(pos: Vector2) -> Vector2i:
	var world_position = Util.screen_to_world(pos, GameManager.camera);
	var grid_position = Navigation.world_to_map(world_position);
	return grid_position;

func update_action() -> void:
	if action == null: return;
	action_name.text = action.name();

func _ready() -> void:
	update_action();

func _on_dropped(pos: Vector2) -> void:
	EventBus.clear_all_highlights.emit();
	var grid_position = pos_to_grid(pos);
	if action.is_in_range(origin, grid_position) && !Navigation.is_tile_solid(grid_position):
		dropped.emit(action, grid_position);

func highlight_action_areas(pos: Vector2) -> void:
	EventBus.clear_all_highlights.emit();
	EventBus.highlight_radius.emit(origin, action.range, TileHighlighter.RANGE);
	var grid_position = pos_to_grid(pos);
	if action.is_in_range(origin, grid_position):
		var color;
		EventBus.highlight_area.emit(
			grid_position,
			action.get_tile_info(origin,grid_position),
			TileHighlighter.action_effect_to_color(action.effect())
		);

func _on_dragged(pos: Vector2) -> void:
	highlight_action_areas(pos);

@warning_ignore("shadowed_variable")
const ACTION_ENTRY = preload("res://ui/action_entry/action_entry.tscn");
static func create(origin: Vector2i, action: Action) -> ActionEntry:
	var action_entry = ACTION_ENTRY.instantiate();
	action_entry.origin = origin;
	action_entry.action = action;
	return action_entry;
