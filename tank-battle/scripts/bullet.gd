extends Area2D

@export var speed = 300
@export var direction = Vector2()

func _physics_process(delta: float) -> void:
	global_position += direction * (speed * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_entered(area: Area2D) -> void:
	area.die()
	queue_free()
