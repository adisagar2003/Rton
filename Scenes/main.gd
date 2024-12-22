extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var debugTargetButton = $DebugLayer/Control/HBoxContainer/Button;
	debugTargetButton.text = "RandomEnemyLocationToGo"
	debugTargetButton.pressed.connect($Navgrid.getRandomPointInArea);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Debug"):
		$DebugLayer.visible = !$DebugLayer.visible;
	pass
