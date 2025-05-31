extends Node


func _on_enemy_spawner_enemy_spawned(enemy_instance: Area2D) -> void:
	add_child(enemy_instance)
	print("spawning enemy")
