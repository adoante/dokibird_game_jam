extends Control

@onready var score_label: Label = $ScoreLabel
@onready var combo_meter_label: Label = $ComboMeterLabel

@onready var seg_1_fill = {
	"VTuber Friend Mint": preload("res://assets/UI/mint_progress_bar_1.png"),
	"VTuber Friend Dooby": preload("res://assets/UI/dooby_progress_bar_1.png"),
	"VTuber Friend Chibidoki": preload("res://assets/UI/chibidoki_progress_bar_1.png"),
	"VTuber Friend Nimi": Texture2D
}

@onready var seg_2_fill = {
	"VTuber Friend Mint": preload("res://assets/UI/mint_progress_bar_2.png"),
	"VTuber Friend Dooby": preload("res://assets/UI/dooby_progress_bar_2.png"),
	"VTuber Friend Chibidoki": preload("res://assets/UI/chibidoki_progress_bar_2.png"),
	"VTuber Friend Nimi": Texture2D
}

@onready var seg_3_fill = {
	"VTuber Friend Mint": preload("res://assets/UI/mint_progress_bar_3.png"),
	"VTuber Friend Dooby": preload("res://assets/UI/dooby_progress_bar_3.png"),
	"VTuber Friend Chibidoki": preload("res://assets/UI/chibidoki_progress_bar_3.png"),
	"VTuber Friend Nimi": Texture2D
}

func _process(_delta):
	score_label.text = "Score: " + str(int(GameManager.get_score()))
	combo_meter_label.text = "Combo: " + str(int(GameManager.get_combo_meter()))
