extends Node2D

@export var columns: int = 8
@export var rows: int = 8
@export var hSeparation: int = 24
@export var vSeparation: int = 25

var brickVSize: int = 18
var brickHSize: int = 87

var packedBrick: PackedScene = preload("res://Scenes/brick.tscn")

func _ready() -> void:
	var currentX: float = position.x
	var currentY: float = position.y

	#FIXBUG: the order is not correct and apparently neither the separation, which should take into account the size of the bricks
	for column: int in range(columns):
		for row: int in range(rows):
			var instanceBrick: StaticBody2D = packedBrick.instantiate()
			instanceBrick.global_position = Vector2(currentX, currentY)
			add_child(instanceBrick)
			currentY += vSeparation + brickVSize
		currentX += hSeparation + brickHSize
		currentY = position.y
