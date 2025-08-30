extends Node2D
var time_between_shots:float  = 0.25
var can_shoot: bool = true
const bullet_scene = preload("res://bullet.tscn")
@onready var shootingPos: Marker2D= $Sprite2D/shootingPos
func _ready() ->void:
	$Timer.wait_time = time_between_shots
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot:
		_shoot()
		can_shoot = false
		$Timer.start()
		
func _shoot():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = shootingPos.global_position
	new_bullet.global_rotation = shootingPos.global_rotation
	new_bullet.get_node("Sprite2D").scale = Vector2(5,5)
	get_tree().current_scene.add_child(new_bullet)
func _on_timer_timeout() -> void:
	can_shoot = true  # Replace with function body.
