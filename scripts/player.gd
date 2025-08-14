extends CharacterBody3D

@onready var first_person_sprite_3d: Sprite3D = $FirstPersonSprite3D
@onready var third_person_front_sprite_3d: Sprite3D = $Spinner/ThirdPersonFrontSprite3D
@onready var third_person_back_sprite_3d: Sprite3D = $Spinner/ThirdPersonBackSprite3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dragoon_meter_timer = $DragoonMeterTimer
@onready var boost_meter_timer = $BoostMeterTimer

@export_group("Speeds")
@export var jump_velocity : float = 4.5
@export var base_speed : float = 7.0
@export var boost_bonus : float = 10.0

@export_group("Input Actions")
@export var input_left  : String = "move_left"
@export var input_right : String = "move_right"
@export var input_up    : String = "move_up"
@export var input_down  : String = "move_down"
@export var input_jump  : String = "jump"

var move_speed : float = 0.0
var last_powerup_state: GameManager.PowerUpState

func _ready() -> void:
	switch_to_first_person()
	move_speed = base_speed
	_setup_timers()
	_apply_powerup_state(GameManager.get_powerup_state())

func _physics_process(delta: float) -> void:
	dragoon_meter_timer.wait_time = GameManager.check_dragoon_meter()
	boost_meter_timer.wait_time = GameManager.check_boost_meter()
	
	GameManager.set_boost_meter_time_left(boost_meter_timer.time_left)
	GameManager.set_dragoon_meter_time_left(dragoon_meter_timer.time_left)
	
	if GameManager.get_powerup_state() != last_powerup_state:
		_apply_powerup_state(GameManager.get_powerup_state())
		
	basic_movement(delta)

func _setup_timers():
	dragoon_meter_timer.timeout.connect(_on_dragoon_meter_timer_timeout)
	boost_meter_timer.timeout.connect(_on_boost_meter_timer_timeout)
	
func _on_dragoon_meter_timer_timeout():
	GameManager.clear_dragoon_meter()
	GameManager.set_powerup_state(GameManager.PowerUpState.REGULAR)

func _on_boost_meter_timer_timeout():
	GameManager.clear_boost_meter()
	GameManager.set_powerup_state(GameManager.PowerUpState.REGULAR)
	
func _apply_powerup_state(state: GameManager.PowerUpState, force := false) -> void:
	if not force and state == last_powerup_state:
		return

	var prev := last_powerup_state
	last_powerup_state = state
	
	dragoon_meter_timer.stop()
	boost_meter_timer.stop()

	match state:
		GameManager.PowerUpState.REGULAR:
			move_speed = base_speed
			switch_to_first_person()

		GameManager.PowerUpState.LONG_NECK:
			move_speed = base_speed
			switch_to_third_person()
			if prev != GameManager.PowerUpState.LONG_NECK:
				dragoon_meter_timer.start()
		GameManager.PowerUpState.BOOST:
			move_speed = base_speed + boost_bonus
			switch_to_first_person()
			if prev != GameManager.PowerUpState.BOOST:
				boost_meter_timer.start()

func switch_to_first_person() -> void:
	first_person_sprite_3d.visible = true
	third_person_front_sprite_3d.visible = false
	third_person_back_sprite_3d.visible = false
	get_parent().switch_camera(1)

func switch_to_third_person() -> void:
	first_person_sprite_3d.visible = false
	third_person_front_sprite_3d.visible = true
	third_person_back_sprite_3d.visible = true
	get_parent().switch_camera(0)

func basic_movement(delta: float) -> void:
	if Input.is_action_just_pressed(input_jump) and is_on_floor():
		velocity.y = jump_velocity

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

	move_and_slide()
