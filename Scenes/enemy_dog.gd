extends CharacterBody2D

var carcass1 = preload("res://Scenes/carcass2.tscn")
var carcass2 = preload("res://Scenes/Carcass.tscn")

@onready var player = $"../Rton";
@onready var cameraShake = $"../CameraShake";
# health
@export var health = 10;

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
	move_and_collide(velocity*delta)
	
func Enemy():
	pass
	
func Patrol():
	# find a random location in the grid.
	# move towards the random location.
	# simple.
	
	pass
	
func TakeDamage():
	health -= 10


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if (body.has_method("Player")):
			var playerState = player.getState();
			var isCarcassAdded = false;
			if (playerState == "Attacking"):
				print("`````````````````````````````Player  Attacked the dog!!!!!```````");
				state = State.HURT;
				# Apply camera shake
				cameraShake.shakeTheCamera();
				
				
				# Apply push away function
					# get the direction of enemy towards player
					# multiply by -1
					# get the value of the vector
					# apply impulsive velocity towards it 
					# use a timer for calculating the duration of impulsive velocity
					
				var directionOfPush = position.direction_to(player.position) * -1;
				velocity = directionOfPush * 700;
				health = health -10;
				if (health < 0):
					
					#modified death 
					# carcass- 2 rigidbodies need to fall at opposite directions
						# enable the carcass
					$CollisionShape2D.disabled = true;
					visible = false;
					
					if !isCarcassAdded:		
						var c1 = carcass1.instantiate();
						var c2 = carcass2.instantiate();
						get_tree().current_scene.add_child(c1)
						get_tree().current_scene.add_child(c2);
						c1.position = position;
						c2.position = Vector2(position.x+6, position.y)
					isCarcassAdded = true;
					
					$CollisionShape2D.disabled = true;
					
					$Death_Timer.start();
					
					pass
					# doesnt collide with anything, they just fall
					# disable all other collisions
					# when reaches an invisible collider, destroy this object
					
				else:
					$Enemy_Timer.start();
				# apply screenshake fx
				
				pass
	pass # Replace with function body.


func _on_enemy_timer_timeout() -> void:
	velocity = position.direction_to(player.position)*20
	pass # Replace with function body.


func _on_death_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
