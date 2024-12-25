extends Node2D
@onready var navgrid: Area2D = $"../Navgrid"
# Called when the node enters the scene tree for the first time.
var numberOfEnemiesToSpawn = 0;
var currentNumberOfEnemies = 0;
@onready var enemyScene = preload("res://Scenes/EnemyDog.tscn");
func _ready() -> void:
	# Spawn an enemy initially;
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (currentNumberOfEnemies == 0):
		# Everytime the player eliminates everyone, the number of enemies that 
		# are spawned should
		# be more than 1
		
		numberOfEnemiesToSpawn += 1;
		# initialize the spawn
		SpawnEnemies();
		pass
	pass

func SpawnEnemies():
	for i in range(numberOfEnemiesToSpawn):
		
		# get a random location 
		var randomLocation = navgrid.getRandomPointInArea();
		var enemy:CharacterBody2D =  enemyScene.instantiate()
		currentNumberOfEnemies+=1;
		print("Should spawn an enemy")
		get_tree().current_scene.add_child(enemy);
		enemy.global_position = randomLocation;
		pass
