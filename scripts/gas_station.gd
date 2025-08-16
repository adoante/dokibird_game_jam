extends Area3D

@export var speed := 2.0
@export var point_amount: float
@export var scene_name: String

var triggered := false

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func _on_body_entered(body):
	if triggered:
		return
	
	if body.name == "Player":
		triggered = true

		visible = false
		
		queue_free()
	
		SceneManager.call_deferred("goto_score_card")
