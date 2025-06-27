extends ParallaxBackground

@export var scroll_speed = 10
@export var bg_texture: CompressedTexture2D = preload("res://assets/textures/bg/Blue.png")

func _ready() -> void:
	$ParallaxLayer/Sprite2D.texture = bg_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ParallaxLayer/Sprite2D.region_rect.position += delta * Vector2(scroll_speed, scroll_speed)
	
	if $ParallaxLayer/Sprite2D.region_rect.position >= Vector2(64, 64):
		$ParallaxLayer/Sprite2D.region_rect.position = Vector2.ZERO
