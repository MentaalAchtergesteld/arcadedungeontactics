class_name Action;
extends Resource

signal executed;

enum Effect {
	Neutral,
	Positive,
	Negative
}

func name() -> String: return "Action";
func effect() -> Effect: return Effect.Neutral;

func get_valid_target_tiles(caster: Unit, origin: Vector2i) -> Array[Vector2i]:
	return [];

func is_valid_target(caster: Unit, origin: Vector2i, target: Vector2i) -> bool:
	return get_valid_target_tiles(caster, origin).has(target);

func get_effect_tiles(caster: Unit, origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	return [];

func execute(caster: Unit, origin: Vector2i, target: Vector2i) -> void:
	
	executed.emit.call_deferred();
