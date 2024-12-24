extends ProgressBar

@onready var rton: CharacterBody2D = $"../../../../Rton"
@onready var health_screen: CanvasLayer = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = rton.health;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = rton.health;
	if (value  ==  0):
		health_screen.queue_free();
		# pause the tree 
		rton.queue_free();
	pass
