extends Area3D

func _on_area_entered(area):
	#print("Removing: " + str(area.name))
	area.queue_free()
