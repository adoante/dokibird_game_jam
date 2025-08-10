extends Area3D

@export var speed := 2.0
var particles: Array[PackedScene]

var triggered := false

func _ready() -> void:
	particles.append(preload("res://scenes/Particles/smoke_particles.tscn"))
	particles.append(preload("res://scenes/Particles/smoke_2_particles.tscn"))
	
func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func _on_body_entered(body):
	if triggered:
		return
	
	if body.name == "Player":
		triggered = true
		
		visible = false
		
		await _spawn_particles()
		
		queue_free()
	
func _spawn_particles() -> void:
	if particles.size() == 0:
		return
	
	# Pick a random paritcle packed scene
	var scene = particles[randi() % particles.size()]
	
	var p := scene.instantiate() as GPUParticles3D

	# position at the truck
	p.global_transform = global_transform
	get_tree().current_scene.add_child(p)

	p.emitting = true

	# cleanup after it finishes
	var seconds: float = (p.lifetime / max(p.speed_scale, 0.0001)) + 0.1
	await get_tree().create_timer(seconds).timeout
	if is_instance_valid(p):
		p.queue_free()
