extends Node

signal out_bounds
signal health_depleted

var score: int = 0
var highestScore: int = 0

var playerHealth: int = 3

func emit_out_bounds() -> void:
	out_bounds.emit()

func emit_health_depleted() -> void:
	health_depleted.emit()

func restart_game_variables() -> void:
	score = 0
	playerHealth = 3