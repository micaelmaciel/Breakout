extends Label

func _process(delta):
    text = "Health: " + str(GlobalProperties.playerHealth)
