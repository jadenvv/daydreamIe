extends Sprite2D

@onready var RayCast: RayCast2D = $RayCast2D

var speed: float = 500.0
func _physics_process(delta: float) -> void:
	global_position += Vector2(1,0) * speed * delta 
	if RayCast.is_colliding():
		var who = RayCast.get_collider()
		if "take_damage" in who and who.is_in_group("enemy"): 
			who.take_damage()
			queue_free()
	
