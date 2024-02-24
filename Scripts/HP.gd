extends Label

func _process(_delta: float) -> void:
    text = "Health: " + str(GlobalProperties.playerHealth)
