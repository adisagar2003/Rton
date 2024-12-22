extends Node

@onready var camera = $"../Camera2D";

@export var SHAKE_INTENSITY = 30.0;
@export var SHAKE_FADE = 5.0;

var currentShakeValue = Vector2(0,0)
var rnb = RandomNumberGenerator.new();
func generateRandomOffset():
	return Vector2(rnb.randf_range(-SHAKE_INTENSITY,SHAKE_INTENSITY),rnb.randf_range(-SHAKE_INTENSITY,SHAKE_INTENSITY));
 

	
func shakeTheCamera():
	currentShakeValue = generateRandomOffset();
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Fade out the intensity over timee
	if ((currentShakeValue.x > 0 or currentShakeValue.x < 0) and (currentShakeValue.y < 0 or currentShakeValue.y > 0) ):
		currentShakeValue = lerp(currentShakeValue, Vector2.ZERO , delta*SHAKE_FADE);
		camera.offset = currentShakeValue;
		
	pass
