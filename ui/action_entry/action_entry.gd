class_name ActionEntry
extends PanelContainer

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

@warning_ignore("shadowed_variable")
const ACTION_ENTRY = preload("res://ui/action_entry/action_entry.tscn");
static func create(action: Action) -> ActionEntry:
	var action_entry = ACTION_ENTRY.instantiate();
	action_entry.action = action;
	return action_entry;
