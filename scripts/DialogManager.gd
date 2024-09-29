extends Node


@onready var text_box_scene_test = preload("res://scenes/elements/TextBoxTest.tscn")
@onready var text_box_scene_militant = preload("res://scenes/elements/TextBoxMilitant.tscn")
@onready var text_box_scene_reponse = preload("res://scenes/elements/TextBoxReponse.tscn")
@onready var text_box_scene_elec = preload("res://scenes/elements/TextBoxElec.tscn")


var dialog_lines: Array[String] = []
var current_line_index =  0
var text_box

enum TextBoxTypes{MILITANT, REPONSE, ELEC, TEST}

var text_box_type

var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

var panelInitialSize

signal textFinished
signal inputFinished

func start_dialog(position:Vector2, 
					apanelInitialSize:Vector2,
					type:TextBoxTypes,
					lines:Array[String]):
	text_box_type = type
	
	if is_dialog_active:
		return
	
	panelInitialSize = apanelInitialSize
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialog_active = true
	
	return self
	
func _show_text_box():
	
	match text_box_type:
		TextBoxTypes.MILITANT:
			text_box = text_box_scene_militant.instantiate()
		TextBoxTypes.REPONSE:
			text_box = text_box_scene_reponse.instantiate()
			text_box.buttonPressed.connect(_on_text_box_button_pressed)
		TextBoxTypes.ELEC:
			text_box = text_box_scene_elec.instantiate()
		TextBoxTypes.TEST:
			text_box = text_box_scene_test.instantiate()
	
	
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position - Vector2(0, text_box.size.y)
	text_box.display_text(dialog_lines[current_line_index], panelInitialSize)
	can_advance_line = false
	

func _on_text_box_finished_displaying():
	can_advance_line = true
	textFinished.emit(self)

func inputCloseDialog():
	text_box.queue_free()
	current_line_index += 1
	if current_line_index >= dialog_lines.size():
		is_dialog_active = false
		current_line_index = 0
		inputFinished.emit(self)
		return
	
	_show_text_box()

func _on_text_box_button_pressed():
	print("button pressed")

func _unhandled_input(event):
	if(
		event.is_action_pressed("advanced_dialog") &&
		is_dialog_active &&
		can_advance_line
	):
		inputCloseDialog()
