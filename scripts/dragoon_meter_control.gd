extends Control

@onready var seg_1: TextureProgressBar = $Segments/Seg1
@onready var seg_2: TextureProgressBar = $Segments/Seg2
@onready var seg_3: TextureProgressBar = $Segments/Seg3

@onready var seg_1_fill = {
	"Small Help Truck": preload("res://assets/NPCs/Mascots/dragoon_regular.png"),
	"Long Help Truck": preload("res://assets/NPCs/Mascots/dragoon_long.png"),
	"Chonky Help Truck": preload("res://assets/NPCs/Mascots/dragoon_chonky.png"),
}

@onready var seg_2_fill = {
	"Small Help Truck": preload("res://assets/NPCs/Mascots/dragoon_regular.png"),
	"Long Help Truck": preload("res://assets/NPCs/Mascots/dragoon_long.png"),
	"Chonky Help Truck": preload("res://assets/NPCs/Mascots/dragoon_chonky.png"),
}

@onready var seg_3_fill = {
	"Small Help Truck": preload("res://assets/NPCs/Mascots/dragoon_regular.png"),
	"Long Help Truck": preload("res://assets/NPCs/Mascots/dragoon_long.png"),
	"Chonky Help Truck": preload("res://assets/NPCs/Mascots/dragoon_chonky.png"),
}

func _process(_delta):
	var dragoon_meter = GameManager.get_dragoon_meter()
	var dragoon_size = dragoon_meter.size()
	
	match dragoon_size:
		0:
			seg_1.value = 0
			seg_2.value = 0
			seg_3.value = 0
		1:
			seg_1.texture_progress = seg_1_fill[dragoon_meter[0]]
			seg_1.value = 33.333
		2:
			seg_2.texture_progress = seg_2_fill[dragoon_meter[1]]
			seg_2.value = 33.333
		3:
			seg_3.texture_progress = seg_3_fill[dragoon_meter[2]]
			seg_3.value = 33.333
