extends Control

func _ready() -> void:
    GlobalProperties.health_depleted.connect(_on_player_health_depleted)

func _process(_delta: float) -> void:
    %Score.text = "Score: " + str(GlobalProperties.score)
    %HighestScore.text = "Highest score: " + str(GlobalProperties.highestScore)


func _on_player_health_depleted() -> void:
    GlobalProperties.highestScore = max(GlobalProperties.highestScore, GlobalProperties.score)
    get_tree().paused = true
    visible = true