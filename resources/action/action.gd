class_name Action
extends Resource

signal finished;

func get_tile_info(caster: Unit, origin: Vector2i) -> Array[TileInfo]:
	return [];

func execute(
	caster: Unit,
	origin: Vector2i,
	target: Vector2i,
) -> void:
	finished.emit();
