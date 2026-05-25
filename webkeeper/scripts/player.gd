extends CharacterBody2D


const SPEED = 300.0
var last_direction: Vector2 = Vector2.RIGHT
@onready var animated_sprite_2d: AnimatedSprite2D = $Body

@onready var bullet_scene = preload("res://scenes/bullet.tscn")

@export var can_shoot: bool = false


func _physics_process(_delta: float) -> void:
	process_movement()
	process_animation()

	if Input.is_action_just_pressed("shoot") && can_shoot:
		print("shooting")
		can_shoot = false
		$GunTimer.start()
		shoot()

	$Gun.look_at(get_global_mouse_position())

	move_and_slide()
	
func process_movement() -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO

func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("walk", last_direction)
	else:
		play_animation("idle", last_direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
		
func shoot():
	#$ShootSound.play()
	var bullet_instance = bullet_scene.instantiate()
	$BulletContainer.add_child(bullet_instance)
	
	bullet_instance.global_position = $Gun/Muzzle.global_position
	bullet_instance.direction = (get_global_mouse_position() - $Gun/Muzzle.global_position).normalized()
	bullet_instance.rotation = bullet_instance.direction.angle()
	


func _on_gun_timer_timeout() -> void:
	can_shoot = true
