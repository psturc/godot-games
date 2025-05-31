extends CharacterBody2D

@export var speed: int
@export var rotation_speed: int
@export var gun_cooldown: int

func _ready() -> void:
	$GunTimer.wait_time = gun_cooldown
