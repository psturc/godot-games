extends CharacterBody2D

const SPEED = 300.0

@onready var bullet_scene = preload("res://scenes/bullet.tscn")

@export var can_shoot: bool = false

@export var deathParticle : PackedScene

signal hit

@onready var tank_x_size = $Body.get_rect().size.x

func die():
	
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	
	hit.emit()
	hide()

func _physics_process(_delta: float) -> void:
	
	if !is_visible_in_tree():
		$MovementSound.playing = false
		return

	velocity = Vector2(0,0)
	var screen_size = get_viewport_rect().size
	
	if Input.is_action_pressed("move_right") && !global_position.x > screen_size.x - tank_x_size/2:
		velocity.x = SPEED
		if !$MovementSound.playing:
			$MovementSound.playing = true
	elif Input.is_action_pressed("move_left") && !global_position.x < 0 + tank_x_size/2:
		velocity.x = -SPEED
		if !$MovementSound.playing:
			$MovementSound.playing = true
	else:
		$MovementSound.playing = false
		
	if Input.is_action_just_pressed("shoot") && can_shoot:
		print("shooting")
		can_shoot = false
		$GunTimer.start()
		shoot()

	$Gun.look_at(get_global_mouse_position())

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name != "BackgroundCollision":
			var collider = collision.get_collider()
			print("I collided with ", collider.name)
			die()
			collider.die()
			


func shoot():
	$ShootSound.play()
	var bullet_instance = bullet_scene.instantiate()
	$BulletContainer.add_child(bullet_instance)
	
	bullet_instance.global_position = $Gun/Muzzle.global_position
	bullet_instance.direction = (get_global_mouse_position() - $Gun/Muzzle.global_position).normalized()
	bullet_instance.rotation = bullet_instance.direction.angle()
	


func _on_gun_timer_timeout() -> void:
	can_shoot = true


func start(pos: Vector2):
	position = pos
	can_shoot = true
	show()
