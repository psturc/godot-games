extends CharacterBody2D
class_name Player

@export var speed = 100
@export var jump_force = 200
@export var gravity = 600


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if velocity.y < 500:
			velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump"):# and is_on_floor():
		jump(jump_force)
	
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	
	update_animations(direction)
	move_and_slide()


func update_animations(direction: int):
	if is_on_floor():
		if direction == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")
	else:
		if velocity.y > 0:
			$AnimatedSprite2D.play("fall")
		else:
			$AnimatedSprite2D.play("jump")
	if direction != 0:
		$AnimatedSprite2D.flip_h = (direction == -1)
			
func jump(force):
	velocity.y = -force
