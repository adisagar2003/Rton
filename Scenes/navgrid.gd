extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	getRandomPointInArea();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getRandomPointInArea():
	var  shapeArea = $CollisionShape2D.shape.get_rect();
	print("----",shapeArea.position.x,"ShapeArea.position.x---");
	print (
		
		{
			"shapeAreaEndY": shapeArea.end.y+global_position.y,
			"shapeAreaEndX": shapeArea.end.x+global_position.x,
			"ShapeAreaX": shapeArea.position.x + global_position.x,
			"ShapeAreaY":shapeArea.position.y+global_position.y,
			"globalPosition":self.global_position
		}
	)
	var randomX = randi_range(shapeArea.position.x+global_position.x, shapeArea.end.x+global_position.x);
	var randomY = randi_range(shapeArea.position.y+global_position.y, shapeArea.end.y+global_position.y);
	
	return Vector2(randomX, randomY);
	
