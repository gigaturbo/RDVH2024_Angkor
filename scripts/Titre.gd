extends Node2D

@export var mainScene : PackedScene

signal startButtonPressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_texture_buttoncustom_pressed():
	startButtonPressed.emit()
	pass # Replace with function body.
