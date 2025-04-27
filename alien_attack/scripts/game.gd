extends Node2D

var lives: int = 3
var score: int = 0


var gos_scene = preload("res://scenes/game_over_screen.tscn")

func _ready() -> void:
	$UI/HUD.set_lives(lives)
	$UI/HUD.set_score(score)
	

func _on_deathzone_area_entered(enemy: Area2D) -> void:
	enemy.queue_free()


func _on_player_took_damage() -> void:
	$PlayerTookDamageSound.play()
	lives -= 1
	$UI/HUD.set_lives(lives)
	if lives == 0:
		$Player.die()
		await get_tree().create_timer(1).timeout
		var gos_instance = gos_scene.instantiate()
		gos_instance.set_score(score)
		$UI.add_child(gos_instance)
		


func _on_enemy_spawner_enemy_spawned(enemy_instance: Area2D) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)



func _on_enemy_died():
	score += 50
	$UI/HUD.set_score(score)
	$EnemyDiedSound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance: PathEnemy) -> void:
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
