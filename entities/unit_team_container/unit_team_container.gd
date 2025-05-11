class_name UnitTeamContainer
extends Node2D

signal battle_over(winning_team: UnitTeam);
signal battle_draw;

var teams: Array[UnitTeam] = [];
var current_team_index: int = 0;

func check_game_end():
	var alive_teams = teams.filter(func(team): return !team.active_units.is_empty());
	
	if alive_teams.is_empty():
		battle_draw.emit();
		return true;
	elif alive_teams.size() == 1:
		battle_over.emit(alive_teams[0]);
		return true;
	else:
		return false;

func end_team_turn() -> void:
	if check_game_end(): return;
	
	current_team_index += 1;
	if current_team_index >= teams.size():
		current_team_index = 0;
	
	start_team_turn();

func start_team_turn() -> void:
	var team = teams[current_team_index];
	if !team.active_units.is_empty():
		team.start_turn();
		await team.turn_complete;
	
	end_team_turn();

func start_battle() -> void:
	start_team_turn();

func load_teams() -> void:
	teams = [];
	for child in get_children():
		if child is UnitTeam:
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
