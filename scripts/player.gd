extends CharacterBody3D

# states
enum State {
	FIRST_PERSON,
	THIRD_PERSON,
}

var current_state: State = State.FIRST_PERSON

@onready var first_person_sprite_3d: Sprite3D = $FirstPersonSprite3D
@onready var third_person_front_sprite_3d: Sprite3D = $Spinner/ThirdPersonFrontSprite3D
@onready var third_person_back_sprite_3d: Sprite3D = $Spinner/ThirdPersonBackSprite3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export_group("Speeds")
## Speed of jump.
@export var jump_velocity : float = 4.5
## Normal speed.
@export var base_speed : float = 7.0

@export_group("Input Actions")
## Name of Input Action to move Left.
@export var input_left : String = "move_left"
## Name of Input Action to move Right.
@export var input_right : String = "move_right"
## Name of Input Action to move Forward.
@export var input_up : String = "move_up"
## Name of Input Action to move Backward.
@export var input_down : String = "move_down"
## Name of Input Action to Jump.
@export var input_jump : String = "jump"

var move_speed : float = 0.0

func _ready() -> void:
	move_speed = base_speed
	pass
	
func _physics_process(delta: float) -> void:
	match current_state:
		State.FIRST_PERSON:
			handle_first_person_state(delta)
		State.THIRD_PERSON:
			handle_third_person_state(delta)

func set_state(new_state: State):
	current_state = new_state

func handle_first_person_state(delta):
	first_person_sprite_3d.visible = true
	third_person_front_sprite_3d.visible = false
	third_person_back_sprite_3d.visible = false
	basic_movement(delta)

func handle_third_person_state(delta):
	first_person_sprite_3d.visible = false
	third_person_front_sprite_3d.visible = true
	third_person_back_sprite_3d.visible = true
	basic_movement(delta)

func basic_movement(delta):
	# Apply jumping
	if Input.is_action_just_pressed(input_jump) and is_on_floor():
		velocity.y = jump_velocity
			
	# Apply gravity to velocity
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation_player.play("spin_3rd_person")

	var input_dir := Input.get_vector(input_left, input_right, input_up, input_down)
	var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if move_dir:
		velocity.x = move_dir.x * move_speed
		velocity.z = move_dir.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	# Use velocity to actually move
	move_and_slide()
