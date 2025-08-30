extends Node
signal changed(value: int)

var value: int = 0

func reset() -> void:
	value = 0
	changed.emit(value)

func add(points: int) -> void:
	value += points
	changed.emit(value)
