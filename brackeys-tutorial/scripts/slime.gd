extends Area2D


const SPEED = 60
const DIE_SPEED = 200

var killed: bool = false
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone
@onready var died_sound: AudioStreamPlayer2D = $DiedSound


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	if killed:
		position.y += DIE_SPEED * delta
	else:
		position.x += SPEED * direction * delta





func _on_body_entered(body: Node2D) -> void:
	print("body enteres")
	if body.name == "player":
		killzone.queue_free()
		killed = true
		died_sound.play()
		await get_tree().create_timer(1).timeout
		queue_free()
