extends CharacterBody2D



@onready var player = $"../Rton";
# health
@export var health = 20;

# 
enum State {PATROL, HURT, CHASE, ATTACK}
var state = State.PATROL;
var randomLocation = Vector2.ZERO
@export var SPEED = 100;
# try to get the player reference
	
func _ready() -> void:
	Patrol();

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
	if (velocity.x < 0):
		$Sprite2D.flip_h = true;
	if (velocity.x > 0):
		$Sprite2D.flip_h = false;
	move_and_slide()
	
func Enemy():
	pass
	
func Patrol():
	if (state == State.PATROL):
		pass
	pass
	
func TakeDamage():
	health -= 10


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if (body.has_method("Player")):
			var playerState = player.getState();
			if (playerState == "Attacking"):
				print("`````````````````````````````Player  Attacked the dog!!!!!```````");
				state = state.HURT;
				# apply screenshake fx
				
				pass
	pass # Replace with function body.
