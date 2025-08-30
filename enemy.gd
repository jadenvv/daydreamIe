extends CharacterBody2D

@export var hit_cooldown := 0.5
var _can_hurt :=true
var hp := 100
@export var points = 100 
func _ready():
	$Area2D.body_entered.connect(on_hurt)
func on_hurt(b: Node) ->void:
	if not _can_hurt: return
	if b.is_in_group("character") and b.has_method("take_damage"):
		b.take_damage()
		_can_hurt = false 
		var tree := get_tree()
		if tree:
			await tree.create_timer(hit_cooldown).timeout
		_can_hurt = true 
func take_damage(amount: int =20) ->void:
	hp -= 20 
	if hp <= 0:
		die() 
@export var move_speed := 30.0
var dir := -1

func _physics_process(delta: float) -> void:
	velocity.x = dir * move_speed
	move_and_slide()

func die() -> void: 
	Score.add(points)
	queue_free()
