extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(self.RestartTheGame);
	pass # Replace with function body.

# After pressing, make it enough.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func RestartTheGame():
	print("This button is working");
	get_tree().paused = false;
	get_tree().reload_current_scene();
