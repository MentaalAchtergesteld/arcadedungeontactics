class_name HealAction
extends Action

@export var range: int = 3;
@export var heal: int = 1;

func name() -> String: return "Heal";
func effect() -> Effect: return Effect.Positive;

func get_tile_info(origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	var result: Array[Vector2i] = [];
	result.append(target);
	
	return result;


func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	var target_unit = GameManager.units.get_unit_at_position(target);
	if target_unit == null: return;
	target_unit.health_component.heal(heal);
	
	finish();
