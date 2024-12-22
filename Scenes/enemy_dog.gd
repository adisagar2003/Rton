extends CharacterBody2D

var carcass1 = preload("res://Scenes/carcass2.tscn")
var carcass2 = preload("res://Scenes/Carcass.tscn")

@onready var player = $"../Rton";
@onready var cameraShake = $"../CameraShake";
# health
@export var health = 20;

@onready var navGrid = $"../Navgrid";
@export var reboundStrength = 500;
# 
enum State {IDLE ,PATROL, HURT, CHASE, ATTACK, WAIT}
var state = State.IDLE;
var randomNewLocationDirection = Vector2.ZERO

@export var SPEED = 100;
# try to get the player reference
	

	
var hasReached = false;
var randomNewLocation = Vector2(0,0);
func _ready() -> void:
	$Patrol_Timer.start();
	pass
	
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
		
	print(state)
	Enemy();
	if (velocity.x < 0):
		$Sprite2D.flip_h = true;
	if (velocity.x > 0):
		$Sprite2D.flip_h = false;
	
	#IDLE STATE
	if state == State.IDLE:
		velocity = Vector2.ZERO;
		
		
	# Chase state --- Chase the player;
	if state == State.CHASE:
		# get the direction towards player;
		var directionTowardsPlayer = position.direction_to(player.position);
		velocity = directionTowardsPlayer * 80;
		print(
			{ "GU":
			position.distance_to(player.position)
			}
			)
		if (position.distance_to(player.position) < 10):
			if (player.getState() != "Attacking"):
				state = State.ATTACK;
				player.getHurt(directionTowardsPlayer);
				# all enemies should wait for a while 
			
				startTheWaitTimer();
				state = State.WAIT;
				pass
			pass
		pass
		
	# PATROL STATE... GETTING A RANDOM Location to go
	if state == State.PATROL:
		# find direction towards the random location;
		var directionTowardsRandomLocation = global_position.direction_to(randomNewLocation);
		velocity = directionTowardsRandomLocation*50;
		if (position.distance_to(randomNewLocation) < 6):
			state = State.IDLE;
			$Patrol_Timer.start();
	move_and_collide(velocity*delta)
	
	# WAIT State... wait for a while...start chasing again
	
func Enemy():
	pass
	

	
# Find a random point to start patrolling
func getRandomLocationDirectionToGo():
	var randomLocationToGo = navGrid.getRandomPointInArea();
	var directionToRandomPosition = position.direction_to(randomLocationToGo);
	return randomLocationToGo;
	
	

func TakeDamage():
	health -= 10

func startTheWaitTimer():
	# this would prevent from calling it recursively.
	if (state != State.WAIT):
		$Wait_Timer.start();
	pass

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
				velocity = directionOfPush * reboundStrength;
				health = health -10;
				# set a timer here.. need to fall back and start attacking.. not immediately
				$Chase_Timer.start();
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


# THIS IS CALLED TO START PATROLLING FROM IDLE FIRST 
func _on_patrol_timer_timeout() -> void:
	randomNewLocation = navGrid.getRandomPointInArea();
	state = State.PATROL
	pass # Replace with function body.


func _on_player_detection_body_entered(body: Node2D) -> void:
	# detect if player entered
	if body.has_method("Player"):
		
		state = State.CHASE
	pass # Replace with function body.


func _on_chase_timer_timeout() -> void:
	print("Start chasing player");
	state = State.CHASE;
	
	pass # Replace with function body.


func _on_wait_timer_timeout() -> void:
	state  =State.CHASE
	pass # Replace with function body.
