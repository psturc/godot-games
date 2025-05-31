extends Area2D

@export var speed = 500
@export var direction = Vector2()

func _physics_process(delta: float) -> void:
	global_position += direction * (speed * delta)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.get_class() == "RigidBody2D":
		print("body ", body.get_class(), " entered")
		body.die()
		queue_free()
