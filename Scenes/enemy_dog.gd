extends CharacterBody2D



@onready var player = $"../Rton";
# health
@export var health = 20;

@export var SPEED = 100;
# try to get the player reference
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	Enemy();
	print(velocity);
	if (velocity.x < 0):
		$Sprite2D.flip_h = true;
	if (velocity.x > 0):
		$Sprite2D.flip_h = false;
	if (player):	
		position = position.move_toward(player.position,delta*SPEED);
	
	move_and_slide()
	
func Enemy():
	pass
	
func TakeDamage():
	health -= 10
