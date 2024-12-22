extends Area2D

@onready var navmarker1: Node2D = $"../Navmarker"
@onready var navmarker2: Node2D = $"../Navmarker2"
@onready var navmarker3: Node2D = $"../Navmarker3"
@onready var navmarker4: Node2D = $"../Navmarker4"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getRandomPointInArea():
	print("I pressed it >:(");
	var randomX = randf_range(navmarker1.global_position.x, navmarker3.global_position.x);
	var randomY = randf_range(navmarker1.global_position.y, navmarker3.global_position.y);
	# instantiate the random point...put  a sprite 2d in it
	# ADDING A SPRITE FOR DEBUG -------------------- ------------------------
	#var markerSprite = Sprite2D.new();
	#markerSprite.scale = Vector2(.02,.02);
	#markerSprite.texture = load("res://icon.svg")
	#markerSprite.global_position = Vector2(randomX, randomY);
	#$"..".add_child(markerSprite)


	return Vector2(randomX, randomY);
