extends Node

signal out_bounds

var score: int = 0
var highestScore: int = 0

func emit_out_bounds() -> void:
	out_bounds.emit()
