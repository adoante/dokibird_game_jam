extends Node

const CREDITS_SCREEN: String = "res://scenes/UI/credits_screen.tscn"
const HOW_TO_PLAY_SCREEN: String = "res://scenes/UI/how_to_play_screen.tscn"
const START_SCREEN: String = "res://scenes/UI/start_screen.tscn"
const PLAY: String = "res://scenes/Levels/downtown.tscn"

func goto_play() -> void: get_tree().change_scene_to_file(PLAY)
func goto_start() -> void: get_tree().change_scene_to_file(START_SCREEN)
func goto_howto() -> void: get_tree().change_scene_to_file(HOW_TO_PLAY_SCREEN)
func goto_credits()-> void:  get_tree().change_scene_to_file(CREDITS_SCREEN)
func exit_game()   -> void:  get_tree().quit()
