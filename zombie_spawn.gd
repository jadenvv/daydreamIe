extends Marker2D

@export var spawn_every := 1.5
@export var start_delay := 0.0
@export var max_alive := 8
@export var jitter := Vector2(8, 0)     
@export var initial_dir := -1            
const enemy_scene = preload("res://enemy.tscn")

var rng := RandomNumberGenerator.new()
var timer := Timer.new()

func _ready() -> void:
	
	rng.randomize()
	add_child(timer)
	timer.wait_time = spawn_every
	timer.one_shot = false
	timer.timeout.connect(_spawn)
	if start_delay > 0:
		await get_tree().create_timer(start_delay).timeout
	timer.start()

func _alive_count() -> int:
	var n := 0
	for e in get_tree().get_nodes_in_group("enemy"):
		if is_instance_valid(e): n += 1
	return n

func _spawn() -> void:
	if enemy_scene == null: return
	if _alive_count() >= max_alive: return
	var e := enemy_scene.instantiate()
	e.scale = Vector2(0.25,0.25)
	var off := Vector2(rng.randf_range(-jitter.x, jitter.x), rng.randf_range(-jitter.y, jitter.y))
	e.global_position = global_position + off
	get_tree().current_scene.add_child(e)
