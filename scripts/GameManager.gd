extends Node

# states
enum PowerUpState {
	REGULAR,
	LONG_NECK,
	BOOST,
}

var score: float = 0.0
var current_powerup_state: PowerUpState = PowerUpState.REGULAR
var boost_meter: Array[String]
var dragoon_meter: Array[String]
var hit_counts = {
	"Small Help Truck": 0,
	"Long Help Truck": 0,
	"Chonky Help Truck": 0,
	"NPC Blue Car": 0,
	"NPC Grey Car": 0,
	"NPC Orange Car": 0,
	"NPC Red Car": 0,
	"Vtuber Friend Mint": 0,
	"Vtuber Friend Dooby": 0,
	"Vtuber Friend Chibidoki": 0,
	"Vtuber Friend Nimi": 0
}

func _ready():
	pass

func update_score(points: float):
	score += points
	print("Score: " + str(score))
	
func update_hit_counts(key: String):
	hit_counts[key] += 1
	print(str(key) + " hit counts: " + str(hit_counts[key]))

func set_powerup_state(new_state: PowerUpState):
	current_powerup_state = new_state

func check_boost_meter():
	print(boost_meter)
	
func check_dragoon_meter():
	if dragoon_meter == ["Small Help Truck", "Chonky Help Truck", "Long Help Truck"]:
		current_powerup_state = PowerUpState.LONG_NECK
	print(dragoon_meter)
	
func clear_boost_meter():
	boost_meter.clear()
	
func clear_dragoon_meter():
	dragoon_meter.clear()
	
func update_dragoon_meter(scene_name: String):
	if dragoon_meter.size() < 3:
		dragoon_meter.append(scene_name)
