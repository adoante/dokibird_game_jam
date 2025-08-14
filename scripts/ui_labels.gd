extends Control

@onready var dragoon_meter_label: Label = $DragoonMeterLabel
@onready var score_label: Label = $ScoreLabel
@onready var combo_meter_label: Label = $ComboMeterLabel

func _process(_delta):
	score_label.text = "Score: " + str(int(GameManager.get_score()))
	dragoon_meter_label.text = str(GameManager.get_dragoon_meter())
	combo_meter_label.text = "Combo: " + str(int(GameManager.get_combo_meter()))
