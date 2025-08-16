extends Node

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

var bgm_tracks = {
	SceneManager.ScreenState.STORY_1: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
	SceneManager.ScreenState.STORY_2: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
	SceneManager.ScreenState.STORY_3: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
	SceneManager.ScreenState.THANKS: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
	SceneManager.ScreenState.CREDITS: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
	SceneManager.ScreenState.HOW_TO_PLAY: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
	SceneManager.ScreenState.START: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
	SceneManager.ScreenState.DOWNTOWN: preload("res://assets/Audio/BGM/DownTown_KarlCasey_WhiteBatIII_Dominion.ogg"),
	SceneManager.ScreenState.BIGCITY: preload("res://assets/Audio/BGM/BigCity_KarlCasey_WhiteBatIII_Fortress.ogg"),
	SceneManager.ScreenState.RUSTIC: preload("res://assets/Audio/BGM/RusticLevel_KarlCasey_WhiteBatIII_DeathSentence.ogg"),
	SceneManager.ScreenState.SCORE: preload("res://assets/Audio/BGM/TitleScreen_KarlCasey_WhiteBatIII_AmongtheRuins.ogg"),
}

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)
	music_player.volume_db = -15
	
	music_player.stream = bgm_tracks[SceneManager.ScreenState.START]
	music_player.play()
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = "SFX"
	add_child(sfx_player)

func set_bgm_music(screen: SceneManager.ScreenState) -> void:
	if screen in bgm_tracks:
		var new_track = bgm_tracks[screen]
		if music_player.stream != new_track:
			music_player.stream = new_track
			music_player.play()
