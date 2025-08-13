extends Label

func _process(_delta):
	text = str(GameManager.get_dragoon_meter())
