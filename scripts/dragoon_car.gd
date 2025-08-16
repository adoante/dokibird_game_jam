extends Area3D

@onready var front: Sprite3D = $Front
@onready var back: Sprite3D = $Back
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bird_get_sfx: AudioStreamPlayer3D = $BirdGetSFX

@export var animations: Array[String] = ["yeet_1", "yeet_2", "yeet_3"]
@export var particles: PackedScene
@export var speed := 2.0
@export var rotate_confetti_flat := true
@export var point_amount: float
@export var scene_name: String

var truck_empty_back: Texture2D
var truck_empty_front: Texture2D
var chonky_particles: PackedScene
var long_particles: PackedScene
var regular_particles: PackedScene

var triggered := false

func _ready() -> void:
	truck_empty_back = load("res://assets/Enemies/TruckEmptyBack.png")
	truck_empty_front = load("res://assets/Enemies/TruckEmptyFront.png")
	
	randomize()
	
func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func _on_body_entered(body: Node3D) -> void:
	if triggered:
		return
	
	if body.name == "Player":
		triggered = true

		bird_get_sfx.play()

		GameManager.update_score(point_amount)
		GameManager.update_combo_meter(point_amount)
		GameManager.update_hit_counts(scene_name)
		GameManager.update_dragoon_meter(scene_name)
	
		front.texture = truck_empty_front
		back.texture = truck_empty_back
		
		_spawn_particles()

		var animation_name = animations[randi() % animations.size()]
		animation_player.play(animation_name)

		await animation_player.animation_finished
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
