extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("you died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()
	Engine.time_scale = 1
