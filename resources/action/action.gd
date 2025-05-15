class_name Action
extends Resource

signal finished;

enum Effect {
	Neutral,
	Positive,
	Negative
};

func name() -> String: return "Action";
func effect() -> Effect: return Effect.Neutral;

func finish() -> void:
	call_deferred("emit_signal", "finished");

func get_tile_info(origin: Vector2i, target: Vector2i) -> Array[Vector2i]:
	return [];

func is_in_range(origin: Vector2i, pos: Vector2i) -> bool:
	return false;

func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	finish();
