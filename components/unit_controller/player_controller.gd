class_name PlayerController
extends UnitController

var is_controlling: bool = false;

var caster: Unit;
var origin: Vector2i;
var chosen_action: Action = null;

func _on_action_chosen(action: Action) -> void:
	if !is_controlling: return;
	
	chosen_action = action;
	EventBus.clear_highlights.emit();
	EventBus.highlight_tiles.emit(action.get_tile_info(caster, origin));

func _on_tile_clicked(position: Vector2i) -> void:
	if !is_controlling: return;
	if chosen_action == null: return;
	
	EventBus.clear_highlights.emit();
	EventBus.hide_actions.emit();
	
	chosen_action.execute(caster, origin, position);
	is_controlling = false;
	finish();

func start(_caster: Unit, _origin: Vector2i) -> void:
	chosen_action = null;
	is_controlling = true;
	caster = _caster;
	origin = _origin;
	
	EventBus.show_actions.emit(actions);

func setup(actions: Array[Action]) -> void:
	super(actions);
	
	EventBus.action_chosen.connect(_on_action_chosen);
	EventBus.tile_clicked.connect(_on_tile_clicked);
