extends Area2D

@export var jump_force: int = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("jump")
		body.jump(jump_force)
