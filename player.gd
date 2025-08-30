extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var hearts: HBoxContainer = $Panel2/HBoxContainer

var lives = 3
func take_damage(amount: int =1 ) -> void: 
	lives -= amount 
	_update_hearts()
	if lives <= 0:
		queue_free()
		get_tree().reload_current_scene()
func _update_hearts():
	var i :=1 
	for h in hearts.get_children(): 
		if h is TextureRect:
			h.visible = i <= lives
			i +=1 
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
