extends Node

# states
enum PowerUpState {
	REGULAR,
	LONG_NECK,
	BOOST,
}

var _boost_meter_time_left: float = 0.0
var _dragoon_meter_time_left: float = 0.0

var _score: float = 0.0
var _current_powerup_state: PowerUpState = PowerUpState.REGULAR
var _boost_meter: Array[String]
var _dragoon_meter: Array[String]
var _hit_counts = {
	"Small Help Truck": 0,
	"Long Help Truck": 0,
	"Chonky Help Truck": 0,
	"NPC Blue Car": 0,
	"NPC Grey Car": 0,
	"NPC Orange Car": 0,
	"NPC Red Car": 0,
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

func check_boost_meter():
	var mint_boost_condition = _boost_meter == [
		"VTuber Friend Mint", "VTuber Friend Mint", "VTuber Friend Mint"
	]
	
	var dooby_boost_condition = _boost_meter == [
		"VTuber Friend Dooby", "VTuber Friend Dooby", "VTuber Friend Dooby"
	]
	
	var chibidoki_boost_condition = _boost_meter == [
		"VTuber Friend Chibidoki", "VTuber Friend Chibidoki", "VTuber Friend Chibidoki"
	]
	
	if mint_boost_condition:
		_current_powerup_state = PowerUpState.BOOST
	elif dooby_boost_condition:
		_current_powerup_state = PowerUpState.BOOST
	elif chibidoki_boost_condition:
		_current_powerup_state = PowerUpState.BOOST
	elif _boost_meter.size() == 3 and (!mint_boost_condition or !dooby_boost_condition or !chibidoki_boost_condition):
		_boost_meter.clear()
			
func check_dragoon_meter():
	var long_neck_condition = _dragoon_meter == [
		"Long Help Truck", "Long Help Truck", "Long Help Truck"
	]
	
	if long_neck_condition:
		_current_powerup_state = PowerUpState.LONG_NECK
	elif _dragoon_meter.size() == 3 and !long_neck_condition:
		_dragoon_meter.clear()
		
func clear_boost_meter():
	_boost_meter.clear()
	
func clear_dragoon_meter():
	print("@@@@@@@@@ CLEARING DRAGOON METER @@@@@@@@@")
	_dragoon_meter.clear()
	
func update_dragoon_meter(scene_name: String):
	if _dragoon_meter.size() < 3:
		_dragoon_meter.append(scene_name)
		
func update_boost_meter(scene_name: String):
	if _boost_meter.size() < 3:
		_boost_meter.append(scene_name)
