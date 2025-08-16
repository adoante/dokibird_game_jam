extends Node

enum ScreenState {
	STORY_1,
	STORY_2,
	STORY_3,
	THANKS,
	CREDITS,
	HOW_TO_PLAY,
	START,
	DOWNTOWN,
	BIGCITY,
	RUSTIC,
	SCORE,
}

const CREDITS_SCREEN: String = "res://scenes/UI/credits_card.tscn"
const HOW_TO_PLAY_SCREEN: String = "res://scenes/UI/how_to_play_screen.tscn"
const START_SCREEN: String = "res://scenes/UI/start_screen.tscn"
const THANKS: String = "res://scenes/UI/thanks_card.tscn"

const DOWNTOWN_LEVEL: String = "res://scenes/Levels/downtown.tscn"
const BIGCITY_LEVEL: String = "res://scenes/Levels/big_city.tscn"
const RUSTIC_LEVEL: String = "res://scenes/Levels/rustic.tscn"

const SCORE_CARD: String = "res://scenes/UI/score_card.tscn"

const STORY_1_CARD: String = "res://scenes/UI/story_1.tscn"
const STORY_2_CARD: String = "res://scenes/UI/story_2.tscn"
const STORY_3_CARD: String = "res://scenes/UI/story_3.tscn"

var prev_scene: ScreenState
var current_scene: ScreenState

func exit_game() -> void: get_tree().quit()

func _ready() -> void:
	current_scene = ScreenState.START

func set_current(scene: ScreenState):
	current_scene = scene

func get_current_scene() -> ScreenState:
	return current_scene

func get_prev_scene() -> ScreenState:
	return prev_scene

func goto_story(scene: ScreenState) -> void:
	prev_scene = current_scene
	current_scene = scene
	AudioManager.set_bgm_music(current_scene)
	match scene:
		ScreenState.STORY_1:
			get_tree().change_scene_to_file(STORY_1_CARD)
		ScreenState.STORY_2:
			get_tree().change_scene_to_file(STORY_2_CARD)
		ScreenState.STORY_3:
			get_tree().change_scene_to_file(STORY_3_CARD)

func goto_play(scene: ScreenState) -> void:
	prev_scene = current_scene
	current_scene = scene
	AudioManager.set_bgm_music(current_scene)
	match scene:
		ScreenState.DOWNTOWN:
			get_tree().change_scene_to_file(DOWNTOWN_LEVEL)
		ScreenState.BIGCITY:
			get_tree().change_scene_to_file(BIGCITY_LEVEL)
		ScreenState.RUSTIC:
			get_tree().change_scene_to_file(RUSTIC_LEVEL)
	
func goto_start() -> void:
	prev_scene = current_scene
	current_scene = ScreenState.START
	AudioManager.set_bgm_music(current_scene)
	get_tree().change_scene_to_file(START_SCREEN)
	
func goto_howto() -> void:
	prev_scene = current_scene
	current_scene = ScreenState.HOW_TO_PLAY
	AudioManager.set_bgm_music(current_scene)
	get_tree().change_scene_to_file(HOW_TO_PLAY_SCREEN)
	
func goto_credits()-> void:
	prev_scene = current_scene
	current_scene = ScreenState.CREDITS
	AudioManager.set_bgm_music(current_scene)
	get_tree().change_scene_to_file(CREDITS_SCREEN)

func goto_score_card() -> void:
	prev_scene = current_scene
	current_scene = ScreenState.SCORE
	AudioManager.set_bgm_music(current_scene)
	get_tree().change_scene_to_file(SCORE_CARD)

func goto_thanks() -> void:
	prev_scene = current_scene
	current_scene = ScreenState.THANKS
	AudioManager.set_bgm_music(current_scene)
	get_tree().change_scene_to_file(THANKS)
