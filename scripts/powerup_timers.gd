extends Control

@onready var boost_meter_timer = $BoostMeterTimer
@onready var dragoon_meter_timer = $DragoonMeterTimer

func _process(_delta: float) -> void:
	var boost_time_left = GameManager.get_boost_meter_time_left()
	var dragoon_time_left = GameManager.get_dragoon_meter_time_left()
	
	boost_meter_timer.text = str(int(boost_time_left))
	dragoon_meter_timer.text = str(int(dragoon_time_left))
