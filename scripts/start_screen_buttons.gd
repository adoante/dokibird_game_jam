extends CanvasLayer

@onready var start_button: Button = $StartButton
@onready var how_to_play_button: Button = $HowToPlayButton
@onready var credits_button: Button = $CreditsButton
@onready var exit_button: Button = $ExitButton

@onready var start_animation_player: AnimationPlayer = $StartButton/AnimationPlayer
@onready var how_to_animation_player: AnimationPlayer = $HowToPlayButton/AnimationPlayer
@onready var credits_animation_player: AnimationPlayer = $CreditsButton/AnimationPlayer
@onready var exit_animation_player: AnimationPlayer = $ExitButton/AnimationPlayer

# START
func _on_start_button_pressed() -> void:
	SceneManager.goto_story(SceneManager.ScreenState.STORY_1)

func _on_start_button_mouse_entered() -> void:
	start_animation_player.play("expand_tilt_left_then_right")
	
func _on_start_button_mouse_exited() -> void:
	start_animation_player.play("RESET")

# HOW TO PLAY
func _on_how_to_play_button_pressed() -> void:
	SceneManager.goto_howto()
	
func _on_how_to_play_button_mouse_entered() -> void:
	how_to_animation_player.play("expand_tilt_left_then_right")

func _on_how_to_play_button_mouse_exited() -> void:
	how_to_animation_player.play("RESET")
	
# CREDITS
func _on_credits_button_pressed() -> void:
	SceneManager.goto_credits()

func _on_credits_button_mouse_entered() -> void:
	credits_animation_player.play("expand_tilt_left_then_right")

func _on_credits_button_mouse_exited() -> void:
	credits_animation_player.play("RESET")

# EXIT
func _on_exit_button_pressed() -> void:
	SceneManager.exit_game()

func _on_exit_button_mouse_entered() -> void:
	exit_animation_player.play("expand_tilt_left_then_right")

func _on_exit_button_mouse_exited() -> void:
	exit_animation_player.play("RESET")
