extends Area2D

@export var speed = 300

signal died

func _physics_process(delta: float) -> void:
	global_position.x -= speed*delta

func die():
	queue_free()
	emit_signal("died")


func _on_body_entered(player: Node2D) -> void:
	player.take_damage()
	die()
