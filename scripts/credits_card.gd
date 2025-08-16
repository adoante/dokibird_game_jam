extends CanvasLayer

@onready var continue_animation_player: AnimationPlayer = $ContinueButton/AnimationPlayer
@onready var exit_animation_player: AnimationPlayer = $ExitButton/AnimationPlayer

func _on_exit_button_pressed() -> void:
	SceneManager.exit_game()
	
func _on_exit_button_mouse_entered() -> void:
	exit_animation_player.play("expand_tilt_left_then_right")

func _on_exit_button_mouse_exited() -> void:
	exit_animation_player.play("RESET")
	
func _on_continue_button_pressed() -> void:
	SceneManager.goto_start()
	
func _on_continue_button_mouse_entered() -> void:
	continue_animation_player.play("expand_tilt_left_then_right")

func _on_continue_button_mouse_exited() -> void:
	continue_animation_player.play("RESET")

# cant be bothered to remove the credits connections
