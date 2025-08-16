extends CanvasLayer

@onready var score_card: Label = $ScoreCard
@onready var exit_animation_player: AnimationPlayer = $ExitButton/AnimationPlayer
@onready var continue_animation_player: AnimationPlayer = $ContinueButton/AnimationPlayer
@onready var background: Sprite2D = $Background

func _ready() -> void:
	var hit_counts = GameManager.get_hit_counts()
	score_card.text = "Score: " + str(int(GameManager.get_score())) + "\n\n"
	for key in hit_counts.keys():
		score_card.text = score_card.text + str(key) + ": " + str(hit_counts[key]) + "\n"
	
	var background_path
	match SceneManager.get_prev_scene():
		SceneManager.ScreenState.DOWNTOWN:
			background_path = "res://assets/UI/WellDone1.png"
			background.texture = load(background_path)
			print("DOWNTOWN score card")
		SceneManager.ScreenState.BIGCITY:
			background_path = "res://assets/UI/WellDone2.png"
			background.texture = load(background_path)
			print("BIGCITY score card")
		SceneManager.ScreenState.RUSTIC:
			background_path = "res://assets/UI/WellDone3.png"
			background.texture = load(background_path)
			print("RUSTIC score card")
		_:
			print("no background found for score card")

func _on_exit_button_pressed() -> void:
	SceneManager.exit_game()
	
func _on_exit_button_mouse_entered() -> void:
	exit_animation_player.play("expand_tilt_left_then_right")

func _on_exit_button_mouse_exited() -> void:
	exit_animation_player.play("RESET")
	
func _on_continue_button_pressed() -> void:
	match SceneManager.get_prev_scene():
		SceneManager.ScreenState.DOWNTOWN:
			SceneManager.goto_play(SceneManager.ScreenState.BIGCITY)
		SceneManager.ScreenState.BIGCITY:
			SceneManager.goto_play(SceneManager.ScreenState.RUSTIC)
		SceneManager.ScreenState.RUSTIC:
			SceneManager.goto_credits()
		SceneManager.ScreenState.CREDITS:
			SceneManager.goto_start()

func _on_continue_button_mouse_entered() -> void:
	continue_animation_player.play("expand_tilt_left_then_right")

func _on_continue_button_mouse_exited() -> void:
	continue_animation_player.play("RESET")
