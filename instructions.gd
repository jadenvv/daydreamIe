extends Label

func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	hide()
