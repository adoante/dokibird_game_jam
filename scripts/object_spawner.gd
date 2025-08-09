extends Node3D

@export var object_to_spawn: PackedScene
@export var spawn_interval: float = 1.0  # Seconds
@export var initial_position: Vector3

var spawn_timer := 0.0

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_object()

func spawn_object():
	if not is_inside_tree():
		return  # Don't spawn if this node isn't in the scene yet

	if object_to_spawn:
		var instance = object_to_spawn.instantiate()
		get_tree().current_scene.add_child(instance)
		var random_z = randf_range(-10.0, 10.0)
		instance.global_position = Vector3(initial_position.x, initial_position.y, random_z)
