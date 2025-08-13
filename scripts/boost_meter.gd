extends Control

@onready var boost_meter_ui = $BoostMeter
@onready var seg_1 = $Segments/Seg1
@onready var seg_2 = $Segments/Seg2
@onready var seg_3 = $Segments/Seg3

var boost_meter_empty: Texture2D
var boost_meter_full: Texture2D

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

func _ready():
	boost_meter_empty = preload("res://assets/UI/boost_meter_empty.png")
	boost_meter_full = preload("res://assets/UI/boost_meter_full.png")

func _process(_delta):
	var boost_meter = GameManager.get_boost_meter()
	var boost_size = boost_meter.size()
	
	match boost_size:
		0:
			seg_1.value = 0
			seg_2.value = 0
			seg_3.value = 0
			boost_meter_ui.texture = boost_meter_empty
		1:
			seg_1.texture_progress = seg_1_fill[boost_meter[0]]
			seg_1.value = 33.333
		2:
			seg_2.texture_progress = seg_2_fill[boost_meter[1]]
			seg_2.value = 33.333
		3:
			seg_3.texture_progress = seg_3_fill[boost_meter[2]]
			seg_3.value = 33.333
			boost_meter_ui.texture = boost_meter_full
