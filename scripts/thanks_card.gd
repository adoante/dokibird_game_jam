extends CanvasLayer

@onready var credits_animation_player: AnimationPlayer = $CreditsButton/AnimationPlayer
@onready var exit_animation_player: AnimationPlayer = $ExitButton/AnimationPlayer

func _on_exit_button_pressed() -> void:
	SceneManager.exit_game()
	
func _on_exit_button_mouse_entered() -> void:
	exit_animation_player.play("expand_tilt_left_then_right")

func _on_exit_button_mouse_exited() -> void:
	exit_animation_player.play("RESET")
	
func _on_credits_button_pressed() -> void:
	SceneManager.goto_credits()
	
func _on_credits_button_mouse_entered() -> void:
	credits_animation_player.play("expand_tilt_left_then_right")

func _on_credits_button_mouse_exited() -> void:
	credits_animation_player.play("RESET")

# cant be bothered to remove the continue connections
