class_name UnitTeamContainer
extends Node2D

var teams: Array[Node2D] = [];

func load_teams() -> void:
	teams = [];
	for child in get_children():
		teams.append(child);

func get_units() -> Array[Unit]:
	var all_units: Array[Unit] = [];
	for team in teams:
		var units = team.get_children().filter(func(unit): return unit is Unit);
		all_units.append_array(units);
	return all_units;

func is_same_team(unit_a: Unit, unit_b: Unit) -> bool:
	for team in teams:
		var units = team.get_children();
		if units.has(unit_a) and units.has(unit_b):
			return true;
	return false;

func get_friendles(unit: Unit) -> Array[Unit]:
	var friendly_teams = teams.filter(func(team): return team.get_children().has(unit));
	if friendly_teams.is_empty(): return [];
	
	var friendlies: Array[Unit] = [];
	for team in friendly_teams:
		var units = team.get_children().filter(func(unit): return unit is Unit);
		friendlies.append_array(units);
	
	return friendlies;

func get_enemies(unit: Unit) -> Array[Unit]:
	var enemy_teams = teams.filter(func(team): return !team.get_children().has(unit));
	if enemy_teams.is_empty(): return [];
	
	var enemies: Array[Unit] = [];
	for team in enemy_teams:
		var units = team.get_children().filter(func(unit): return unit is Unit);
		enemies.append_array(units);
	
	return enemies;

func get_unit_at_position(pos: Vector2i) -> Unit:
	for team in teams:
		for unit in team.get_children():
			if unit.grid_position == pos: return unit;
	return null;

func _ready() -> void:
	load_teams();
