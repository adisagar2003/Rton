extends RigidBody2D

@export var linearXVelocity = -300;
@export var linearYVelocity = 200;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = Vector2(linearXVelocity,linearYVelocity)
	$Timer.start();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	
	queue_free();
	pass # Replace with function body.
