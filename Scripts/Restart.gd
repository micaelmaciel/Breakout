extends Button

@export var buttonClickSound: AudioStreamPlayer

func _pressed() -> void:
	buttonClickSound.play(0.02)
	await buttonClickSound.finished
	GlobalProperties.restart_game_variables()
	get_tree().paused = false
	get_tree().reload_current_scene()
