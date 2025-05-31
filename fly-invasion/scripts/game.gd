extends Node

@export var beetle_scene: PackedScene
@onready var tank_scene = preload("res://scenes/tank.tscn")

var score = 0

func game_over():
	for child in get_children():
		if child is Beetle:
			print("CHILD: ", child)
			child.queue_free()
	$EnemyTimer.stop()
	$HUD.show_game_over()
	$EnemyTimer.stop()
	
func new_game():
	score = 0
	$Music.play()
	$HUD/ScoreLabel.text = "SCORE: " + str(score)
	$EnemyTimer.start()
	
	$Tank.start($StartPosition.position)
	
	$HUD.show_message("Go!")


func _on_tank_hit() -> void:
	game_over()

func _on_enemy_timer_timeout() -> void:
	var beetle = beetle_scene.instantiate()

	var beetle_spawn_location = $EnemyPath/EnemySpawnLocation
	beetle_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	beetle.position = beetle_spawn_location.position

	## Set the mob's direction perpendicular to the path direction.
	var direction = beetle_spawn_location.rotation + PI / 2

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 550.0), 0.0)
	beetle.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(beetle)
	
	beetle.connect("died", _on_beetle_died)
	
func _on_beetle_died():
	$EnemyDieExplosionSound.play()
	score += 100
	$HUD/ScoreLabel.text = "SCORE: " + str(score)
	
