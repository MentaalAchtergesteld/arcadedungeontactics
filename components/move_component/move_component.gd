class_name PositionComponent
extends Node

signal movement_finished;

@export var actor: Node2D;
@export var move_speed: float = 0.1;
@export var enabled: bool = true;

var grid_position: Vector2i:
	get: return Navigation.world_to_map(actor.global_position);

func move_to(grid_pos: Vector2i) -> void:
	if !enabled: return;
	actor.global_position = Navigation.map_to_world(grid_pos);
	movement_finished.emit();

func move_along_relative_path(path: Array[Vector2i]) -> void:
	if !enabled: return;
	if path.is_empty(): return;
	
	var tween = create_tween();
	tween.set_ease(Tween.EASE_OUT);
	tween.set_trans(Tween.TRANS_CUBIC);
	
	var path_position = grid_position;
	for pos in path:
		path_position += pos;
		tween.tween_property(
			actor,
			'global_position',
			Navigation.map_to_world(path_position),
			move_speed
		);

	await tween.finished;
	movement_finished.emit();

func move_along_absolute_path(path: Array[Vector2i]) -> void:
	if !enabled: return;
	if path.is_empty(): return;
	
	var tween = create_tween();
	tween.set_ease(Tween.EASE_OUT);
	tween.set_trans(Tween.TRANS_CUBIC);
	
	for pos in path:
		tween.tween_property(
			actor,
			'global_position',
			Navigation.map_to_world(pos),
			move_speed
		);
		
	await tween.finished;
	movement_finished.emit.call_deferred();
