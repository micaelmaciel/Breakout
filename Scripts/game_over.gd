extends Control

func _process(_delta: float) -> void:
    %Score.text = "Score: " + str(GlobalProperties.score)
    %HighestScore.text = "Highest score: " + str(GlobalProperties.highestScore)