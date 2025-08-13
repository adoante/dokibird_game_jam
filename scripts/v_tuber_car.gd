extends Area3D

@export var speed := 2.0
@export var point_amount: float
@export var scene_name: String
@export var particles: PackedScene

var triggered := false

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func _on_body_entered(body):
	if triggered:
		return
	
	if body.name == "Player":
		triggered = true
		
		GameManager.update_score(point_amount)
		GameManager.update_hit_counts(scene_name)
		GameManager.update_boost_meter(scene_name)
		
		visible = false
		
		await _spawn_particles()
		
		queue_free()
	
func _spawn_particles() -> void:
	var p := particles.instantiate() as GPUParticles3D

	# position at the truck
	p.global_transform = global_transform
	get_tree().current_scene.add_child(p)

	p.emitting = true

	# cleanup after it finishes
	var seconds: float = (p.lifetime / max(p.speed_scale, 0.0001)) + 0.1
	await get_tree().create_timer(seconds).timeout
	if is_instance_valid(p):
		p.queue_free()
