extends Node3D
@onready var player: CharacterBody3D = $Player

@onready var camera_3d: Camera3D = $Camera3D
@onready var player_camera_3d: Camera3D = $Player/Camera3D

@export var cameras: Array[Camera3D] = []
var current_index := 0

func _ready():
	cameras = [camera_3d, player_camera_3d]
	
	if cameras.size() > 0:
		_activate_camera(current_index)

func _input(event):
	if event.is_action_pressed("switch_camera"):
		current_index = (current_index + 1) % cameras.size()
		_activate_camera(current_index)

func _activate_camera(index: int):
	if index < 0 or index >= cameras.size():
		return
		
	for i in range(cameras.size()):
		cameras[i].current = (i == index)

	# Inform player about camera mode
	if index == 0:
		player.set_state(player.State.THIRD_PERSON)
	else:
		player.set_state(player.State.FIRST_PERSON)
