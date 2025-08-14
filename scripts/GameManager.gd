extends Node

# states
enum PowerUpState {
	REGULAR,
	LONG_NECK,
	BOOST,
}

var _score: float = 0.0
var _combo_meter: float = 0.0

var _boost_meter: Array[String]
var _dragoon_meter: Array[String]
var _boost_meter_time_left: float = 0.0
var _dragoon_meter_time_left: float = 0.0

var _current_powerup_state: PowerUpState = PowerUpState.REGULAR
var _dragoon_powerup_time: float = 10.0
var _boost_powerup_time: float = 10.0

var _hit_counts = {
	"Small Help Truck": 0,
	"Long Help Truck": 0,
	"Chonky Help Truck": 0,
	"NPC Grey Car": 0,
	"NPC Grey Car Good": 0,
	"VTuber Friend Mint": 0,
	"VTuber Friend Dooby": 0,
	"VTuber Friend Chibidoki": 0,
	"VTuber Friend Nimi": 0
}

func _ready():
	pass

func update_score(points: float):
	_score += points
	print("Score: " + str(_score))
	
func get_score() -> float:
	return _score

func update_combo_meter(points: float):
	if points < 0:
		_combo_meter = 0	
	else:
		_combo_meter += points
		
	print("Combo Meter: " + str(_combo_meter))

func get_combo_meter() -> float:
	return _combo_meter
	
func update_hit_counts(key: String):
	_hit_counts[key] += 1
	print(str(key) + " hit counts: " + str(_hit_counts[key]))

func get_powerup_state() -> PowerUpState:
	return _current_powerup_state

func set_powerup_state(new_state: PowerUpState):
	_current_powerup_state = new_state

func get_boost_meter() -> Array[String]:
	return _boost_meter
	
func get_dragoon_meter() -> Array[String]:
	return _dragoon_meter

func set_boost_meter_time_left(time: float):
	_boost_meter_time_left = time
	
func set_dragoon_meter_time_left(time: float):
	_dragoon_meter_time_left = time
	
func get_boost_meter_time_left() -> float:
	return _boost_meter_time_left
	
func get_dragoon_meter_time_left() -> float:
	return _dragoon_meter_time_left

func check_boost_meter() -> float:
	var mint_boost_condition = _boost_meter == [
		"VTuber Friend Mint", "VTuber Friend Mint", "VTuber Friend Mint"
	]
	
	var dooby_boost_condition = _boost_meter == [
		"VTuber Friend Dooby", "VTuber Friend Dooby", "VTuber Friend Dooby"
	]
	
	var chibidoki_boost_condition = _boost_meter == [
		"VTuber Friend Chibidoki", "VTuber Friend Chibidoki", "VTuber Friend Chibidoki"
	]
	
	var nimi_boost_condition = _boost_meter == [
		"VTuber Friend Nimi", "VTuber Friend Nimi", "VTuber Friend Nimi"
	]
	
	if _boost_meter.size() == 3 and (!mint_boost_condition and !dooby_boost_condition and !chibidoki_boost_condition and !nimi_boost_condition):
		_boost_meter.clear()
		return _boost_powerup_time
	elif nimi_boost_condition:
		_boost_powerup_time = 25.0
		_current_powerup_state = PowerUpState.BOOST
	elif mint_boost_condition:
		_boost_powerup_time = 20.0
		_current_powerup_state = PowerUpState.BOOST
	elif dooby_boost_condition:
		_boost_powerup_time = 15.0
		_current_powerup_state = PowerUpState.BOOST
	elif chibidoki_boost_condition:
		_boost_powerup_time = 10.0
		_current_powerup_state = PowerUpState.BOOST
	
	return _boost_powerup_time 
	
func check_dragoon_meter() -> float:
	var long_neck_condition = _dragoon_meter == [
		"Long Help Truck", "Long Help Truck", "Long Help Truck"
	]
	
	var small_neck_condition = _dragoon_meter == [
		"Small Help Truck", "Small Help Truck", "Small Help Truck"
	]
	
	var chonky_neck_condition = _dragoon_meter == [
		"Chonky Help Truck", "Chonky Help Truck", "Chonky Help Truck"
	]
			
	if _dragoon_meter.size() == 3 and (!long_neck_condition and !small_neck_condition and !chonky_neck_condition):
		_dragoon_meter.clear()
		return _dragoon_powerup_time
	elif long_neck_condition:
		_dragoon_powerup_time = 20.0
		_current_powerup_state = PowerUpState.LONG_NECK
	elif chonky_neck_condition:
		_dragoon_powerup_time = 15.0
		_current_powerup_state = PowerUpState.LONG_NECK
	elif small_neck_condition:
		_dragoon_powerup_time = 10.0
		_current_powerup_state = PowerUpState.LONG_NECK
	
	return _dragoon_powerup_time
	
func clear_boost_meter():
	_boost_meter.clear()
	
func clear_dragoon_meter():
	_dragoon_meter.clear()
	
func update_dragoon_meter(scene_name: String):
	if _dragoon_meter.size() < 3:
		_dragoon_meter.append(scene_name)
		
func update_boost_meter(scene_name: String):
	if _boost_meter.size() < 3:
		_boost_meter.append(scene_name)
