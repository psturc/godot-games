extends RigidBody2D
class_name Beetle

@export var deathParticle : PackedScene

signal died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func die():
	emit_signal("died")
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)

	queue_free()
