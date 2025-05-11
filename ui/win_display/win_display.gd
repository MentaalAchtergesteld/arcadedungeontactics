class_name WinDisplay
extends Control

func _on_set_winner(team: UnitTeam) -> void:
	$Label.text = "Winner: " + team.name + "!";

func _on_set_winner_draw() -> void:
	$Label.text = "Draw!";

func _on_clear_winner() -> void:
	$Label.text = "";

func _ready() -> void:
	EventBus.set_winner.connect(_on_set_winner);
	EventBus.set_winner_draw.connect(_on_set_winner_draw);
	EventBus.clear_winner.connect(_on_clear_winner);
