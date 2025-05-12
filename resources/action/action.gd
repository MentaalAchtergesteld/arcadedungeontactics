class_name Action
extends Resource

signal finished;

func name() -> String: return "Action";

func finish() -> void:
	call_deferred("emit_signal", "finished");

func get_tile_info(caster: Unit, origin: Vector2i) -> Array[TileInfo]:
	return [];

func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	finish();
