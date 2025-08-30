extends Panel

@onready var score_label:Label = $point

func _ready() -> void:
	score_label.text = "0"
	Score.changed.connect(_on_score_changed)
	# If this scene is your level entry point, also reset here:
	Score.reset()

func _on_score_changed(v: int) -> void:
	score_label.text = str(v)
