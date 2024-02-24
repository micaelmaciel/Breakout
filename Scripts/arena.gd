extends Node2D

var gameOver: PackedScene = preload("res://Scenes/game_over.tscn")

func _ready() -> void:
    GlobalProperties.health_depleted.connect(_on_player_health_depleted)
    GlobalProperties.game_won.connect(_on_game_won)



func _on_player_health_depleted() -> void:
    GlobalProperties.highestScore = max(GlobalProperties.highestScore, GlobalProperties.score)
    get_tree().paused = true
    %GameOverScreen.visible = true

func _on_game_won() -> void:
    GlobalProperties.highestScore = max(GlobalProperties.highestScore, GlobalProperties.score)
    get_tree().paused = true
    %WinScreen.visible = true