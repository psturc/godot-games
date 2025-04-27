extends Path2D

class_name PathEnemy

@onready var enemy = $PathFollow2D/Enemy

func _ready() -> void:
	$PathFollow2D.set_progress_ratio(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PathFollow2D.progress_ratio -= 0.25 * delta
	if $PathFollow2D.progress_ratio <= 0:
		queue_free()
