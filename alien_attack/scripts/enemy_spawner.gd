extends Node2D

@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var path_enemy_scene = preload("res://scenes/path_enemy.tscn")

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(enemy_instance)

func _on_timer_timeout() -> void:
	spawn_enemy()


func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	var spawn_positions: Array[Node] = $SpawnPositions.get_children()
	var random_position: Node = spawn_positions.pick_random()
	
	enemy_instance.global_position = random_position.global_position
	emit_signal("enemy_spawned", enemy_instance)


func _on_path_enemy_timer_timeout() -> void:
	spawn_path_enemy()
	
func spawn_path_enemy():
	emit_signal("path_enemy_spawned", path_enemy_scene.instantiate())
	
