extends Label

func _process(_delta):
	text = str(int(GameManager.get_score()))
