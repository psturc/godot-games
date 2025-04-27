extends CharacterBody2D

signal took_damage

@export var speed = 300

@onready var rocket_scene = preload("res://scenes/rocket.tscn")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta: float) -> void:
	velocity = Vector2(0,0)
	var screen_size = get_viewport_rect().size
	
	if Input.is_action_pressed("move_up") && !global_position.y < 0:
		velocity.y = -speed
	if Input.is_action_pressed("move_down") && !global_position.y > screen_size.y:
		velocity.y = speed
	if Input.is_action_pressed("move_right") && !global_position.x > screen_size.x:
		velocity.x = speed
	if Input.is_action_pressed("move_left") && !global_position.x < 0:
		velocity.x = -speed
	

	move_and_slide()
	
	
func shoot():
	var rocket_instance = rocket_scene.instantiate()
	$RocketContainer.add_child(rocket_instance)
	rocket_instance.global_position = global_position + Vector2(70,0)
	$RocketShotSound.play()
	
func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
