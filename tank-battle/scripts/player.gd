extends "res://scripts/tank.gd"

@onready var bullet_scene = preload("res://scenes/bullet.tscn")

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
		$GunTimer.start()
		shoot()

	$Turret.look_at(get_global_mouse_position())
	
	move_and_slide()

func shoot():
	var bullet_instance = bullet_scene.instantiate()
	$BulletContainer.add_child(bullet_instance)
	
	bullet_instance.global_position = $Turret/Muzzle.global_position
	bullet_instance.direction = (get_global_mouse_position() - $Turret/Muzzle.global_position).normalized()
	bullet_instance.rotation = bullet_instance.direction.angle()

func _on_gun_timer_timeout() -> void:
	can_shoot = true
