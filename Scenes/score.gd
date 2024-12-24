extends Label

@onready var rton: CharacterBody2D = $"../../../../Rton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(rton.score);
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(rton.score);
	pass
