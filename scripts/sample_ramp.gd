extends CSGPolygon3D

@export var speed := 2.0

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta
