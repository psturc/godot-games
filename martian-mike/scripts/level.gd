extends Node2D

@export var next_level: PackedScene = null
@export var is_final_level: bool = false

var timer_node: Timer = null
@export var level_time = 5
var time_left

var won = false

func _ready() -> void:
	var traps = get_tree().get_nodes_in_group("traps")
	for trap: Trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
	$Player.position = $Start.get_spawn_pos()
	
	$Exit.body_entered.connect(_on_exit_body_entered)
	$Deathzone.body_entered.connect(_on_deathzone_body_entered)
	
	time_left = level_time
	$UILayer/HUD.set_time_label(str(time_left))
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	
func _on_level_timer_timeout():
	time_left -= 1
	print("time left:", time_left)
	if time_left < 0:
		reset_player()
		time_left = level_time
	$UILayer/HUD.set_time_label(str(time_left))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_deathzone_body_entered(body: CharacterBody2D) -> void:
	reset_player()


func _on_trap_touched_player() -> void:
	reset_player()


func reset_player():
	$Player.position = $Start.get_spawn_pos()
	$Player.velocity = Vector2.ZERO

func _on_exit_body_entered(body):
	if body is Player:
		won = true
		timer_node.stop()
		$Exit.animate()
		await get_tree().create_timer(1.5).timeout
		if next_level != null || is_final_level:
			if is_final_level:
				$UILayer.show_win_screen(true)
			else:
				get_tree().change_scene_to_packed(next_level)
