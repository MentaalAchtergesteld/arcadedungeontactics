class_name PlayerController
extends UnitController

var is_controlling: bool = false;

var caster: Unit;
var origin: Vector2i;
var chosen_action: Action = null;

func _on_action_chosen(action: Action, position: Vector2i) -> void:
	if !is_controlling: return;
	chosen_action = action;
	
	EventBus.hide_actions.emit();
	
	chosen_action.execute(caster, origin, position);
	
	await chosen_action.executed;
	is_controlling = false;
	finish();

func start(_caster: Unit, _origin: Vector2i) -> void:
	chosen_action = null;
	is_controlling = true;
	caster = _caster;
	origin = _origin;
	
	EventBus.show_actions.emit(origin, actions);

func setup(actions: Array[Action]) -> void:
	super(actions);
	
	EventBus.action_chosen.connect(_on_action_chosen);
