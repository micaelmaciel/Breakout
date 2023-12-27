extends Button

func _pressed() -> void:
	GlobalProperties.restart_game_variables()
	get_tree().paused = false
	get_tree().reload_current_scene()
	print(GlobalProperties.score)
	print(GlobalProperties.highestScore)
