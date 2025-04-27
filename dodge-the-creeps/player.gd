extends Area2D

signal hit

@export var speed: int = 400

var screen_size: Vector2
var player_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	var shape: Shape2D = $CollisionShape2D.shape
	player_size = shape.get_rect().size
	print("player size: ", player_size)
	#hide()

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	#print("velocity before normalized:", velocity)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		#print("velocity after normalized:", velocity)
	else:
		$AnimatedSprite2D.stop()
		
	#print("velocity after normalized:", velocity)

	position += velocity * delta
	position = position.clamp(Vector2.ZERO+player_size/2, screen_size-player_size/2)
	
	#print("position:", position, "\n")
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos: Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false
