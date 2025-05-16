class_name UnitTeam
extends Node2D

signal turn_complete;

var units: Array[Unit] = [];
var active_units: Array[Unit] = [];
var unit_index: int = -1;

func load_active_units() -> void:
	active_units = units.filter(func(unit): return unit.alive);

func load_units() -> void:
	units = [];
	units.all(func(unit): unit.died.disconnect(load_active_units));
	for child in get_children():
		if child is Unit:
			units.append(child);
			child.died.connect(load_active_units);
	load_active_units();

func start_turn() -> void:
	active_units = units.filter(func(unit): return unit.alive);
	unit_index = 0;
	
	while unit_index < active_units.size():
		var unit: Unit = active_units[unit_index];
		unit.select();
		unit.start_turn();
		await unit.turn_complete;
		
		await get_tree().create_timer(GameManager.game_speed).timeout;
		unit.deselect();
		
		unit_index += 1;
	
	turn_complete.emit();

func _ready() -> void:
	load_units();
