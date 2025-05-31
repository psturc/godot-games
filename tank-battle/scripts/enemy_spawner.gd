extends Node

@onready var enemy_scene = preload("res://scenes/enemy_tank.tscn")

signal enemy_spawned

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
	
func spawn_enemy():
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = Vector2(55, 80)
	
	emit_signal("enemy_spawned", enemy_instance)
	
	
