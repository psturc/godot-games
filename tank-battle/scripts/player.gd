extends CharacterBody2D


@export var speed: int = 200
@export var rotation_speed: float = 2

var can_shoot: bool = true

func _physics_process(delta: float) -> void:
	velocity = Vector2()

	if Input.is_action_pressed("turn_left"):
		rotation -= rotation_speed * delta
	if Input.is_action_pressed("turn_right"):
		rotation += rotation_speed * delta
	if Input.is_action_pressed("move_forward"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("move_backward"):
		velocity = Vector2(-speed/2.0, 0).rotated(rotation)
	if Input.is_action_just_pressed("shoot") && can_shoot:
		print("shooting")
		can_shoot = false
		$Shoot_cooldown.start()

	$Turret.look_at(get_global_mouse_position())
	
	move_and_slide()




func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
