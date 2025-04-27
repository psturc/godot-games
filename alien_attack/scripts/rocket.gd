extends Area2D

@export var speed = 500

func _ready() -> void:
	$VisibleNotifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
	global_position.x += speed*delta

func _on_screen_exited():
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	queue_free()
	area.die()
