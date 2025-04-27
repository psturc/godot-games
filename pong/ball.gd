extends CharacterBody2D

var speed = 300

func _ready() -> void:
	velocity = Vector2(-10, 5).normalized() * speed

func _physics_process(delta: float) -> void:	
	var collision = move_and_collide(velocity * delta)
	print("velocity:", velocity)
	print(collision)
	if collision:
		print("COLLISION!")
		velocity = velocity.bounce(collision.get_normal())
