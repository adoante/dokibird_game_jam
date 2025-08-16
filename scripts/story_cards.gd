extends CanvasLayer

@onready var continue_animation_player: AnimationPlayer = $ContinueButton/AnimationPlayer

func _on_continue_button_pressed() -> void:
	match SceneManager.get_prev_scene():
		SceneManager.ScreenState.START:
			SceneManager.goto_story(SceneManager.ScreenState.STORY_2)
		SceneManager.ScreenState.STORY_1:
			SceneManager.goto_story(SceneManager.ScreenState.STORY_3)
		SceneManager.ScreenState.STORY_2:
			SceneManager.goto_play(SceneManager.ScreenState.DOWNTOWN)
			
func _on_continue_button_mouse_entered() -> void:
	continue_animation_player.play("expand_tilt_left_then_right")

func _on_continue_button_mouse_exited() -> void:
	continue_animation_player.play("RESET")
