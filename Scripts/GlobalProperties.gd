extends Node

signal health_depleted
signal game_won

var score: int = 0
var highestScore: int = 0

var player: CharacterBody2D


var playerHealth: int = 3

func emit_health_depleted() -> void:
	health_depleted.emit()

func emit_game_won() -> void:
	game_won.emit()

func restart_game_variables() -> void:
	score = 0
	playerHealth = 3