extends Area3D

@export var speed := 2.0
@export var point_amount: float
@export var scene_name: String
@onready var car_crash_sfx: AudioStreamPlayer3D = $CarCrashSFX

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
		
		car_crash_sfx.play()
		
		if GameManager.get_powerup_state() == GameManager.PowerUpState.BOOST or  GameManager.get_powerup_state() == GameManager.PowerUpState.LONG_NECK:
			GameManager.update_score(100)
			GameManager.update_hit_counts("NPC Grey Car Good")
			GameManager.update_combo_meter(100)
		else:
			GameManager.update_score(point_amount)
			GameManager.update_hit_counts(scene_name)
			GameManager.update_combo_meter(point_amount)
		
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
