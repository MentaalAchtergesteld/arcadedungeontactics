class_name ActionChooser
extends Control

@onready var action_box: HBoxContainer = $Actions;

var active: bool = false;

func _on_action_selected(action: Action):
	if !active: return;
	
	for child in action_box.get_children():
		child.deselect();
	
	EventBus.action_chosen.emit(action);

func _on_action_dropped(action: Action, tile_position: Vector2i) -> void:
	EventBus.action_chosen.emit(action, tile_position);

func _on_hide_actions() -> void:
	for child in action_box.get_children():
		child.dropped.disconnect(_on_action_dropped);
		action_box.remove_child(child);

func _on_show_actions(origin: Vector2i, actions: Array[Action]):
	_on_hide_actions();
	
	for action in actions:
		var action_entry = ActionEntry.create(origin, action);
		action_entry.dropped.connect(_on_action_dropped);
		action_box.add_child(action_entry);
	
	open();

func close() -> void:
	active = false;
	visible = false;

func open() -> void:
	visible = true;
	active = true;

func _ready() -> void:
	EventBus.hide_actions.connect(_on_hide_actions);
	EventBus.show_actions.connect(_on_show_actions);
