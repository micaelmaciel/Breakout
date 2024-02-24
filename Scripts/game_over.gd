@tool
extends Control

func _ready() -> void:
    get_parent().set_editable_instance(self, true)

func _process(_delta: float) -> void:
    %Score.text = "Score: " + str(GlobalProperties.score)
    %HighestScore.text = "Highest score: " + str(GlobalProperties.highestScore)