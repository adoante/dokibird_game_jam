extends Node3D

@onready var player: CharacterBody3D = $Player

@onready var third_person_camera: Camera3D = $Camera3D
@onready var first_person_camera: Camera3D = $Player/Camera3D

@export var cameras: Array[Camera3D] = []
var current_index := 1

func _ready():
	cameras = [third_person_camera, first_person_camera]
	
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

	if index == 0:
		GameManager.set_powerup_state(GameManager.PowerUpState.LONG_NECK)
	else:
		GameManager.set_powerup_state(GameManager.PowerUpState.REGULAR)
		
func switch_camera(camera: int):
	_activate_camera(camera)
