extends "res://Scripts/game_over.gd"

func _ready() -> void:
    GlobalProperties.game_won.connect(_on_game_won)


func _on_game_won() -> void:
    GlobalProperties.highestScore = max(GlobalProperties.highestScore, GlobalProperties.score)
    get_tree().paused = true
    visible = true