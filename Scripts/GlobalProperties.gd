extends Node

signal out_bounds

func emit_out_bounds() -> void:
	out_bounds.emit()
