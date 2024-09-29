extends Node2D

var parsedText = ""

@onready var rtl = $MarginContainer/MarginContainer/RichTextLabel

var isFinished = false

signal quitResults

# Called when the node enters the scene tree for the first time.
func _ready():
	var isFinished = false
	$charles_bien.show()
	$charles_bof.show()
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
#	await set_text("okzdz fef fez grzh [b]theqgrEGQH[/b] QTH RTJRTRSTJRST okzdz fef fez" + 
#			 "grzh [b]theqgrEGQH[/b] QTH RTJRTRSTJRST okzdz fef fez grzh [b]theqgrEGQH[/b]" +
#			 " QTH RTJRTRSTJRST dza d azfe fzegezgqezge gqrge rgege qrg egergergeg eeg er" +
#			 " QTH RTJRTRSTJRST dza d azfe fzegezgqezge gqrge rgege qrg egergergeg eeg er").finished
#
#	await charlesBad().finished
	
#	isFinished = true
	
func reset():
	var isFinished = false
	$charles_bien.show()
	$charles_bof.show()
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	$MarginContainer.modulate = Color.TRANSPARENT
	
func showPanel():
	await get_tree().create_timer(0.25)
	var tween = get_tree().create_tween()
	tween.tween_property($MarginContainer, "modulate", Color.WHITE, 0.5)
	
	return tween

func _input(event):
	if isFinished and event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				quitResults.emit(self)
	
func set_text(text):
	rtl.visible_characters = 0
	rtl.visible_characters_behavior = 2
	rtl.parse_bbcode(text)
	parsedText = rtl.get_parsed_text()
	var duration = 0.01*parsedText.length()
	
	await get_tree().create_timer(0.25)
	var tween = get_tree().create_tween()
	tween.tween_property(rtl, "visible_characters", parsedText.length(), duration)
	isFinished = true
	return tween

func charlesGood():
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	var tween = get_tree().create_tween()
	tween.tween_property($charles_bien, "modulate", Color.WHITE, 0.5)
	return tween

func charlesBad():
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	var tween = get_tree().create_tween()
	tween.tween_property($charles_bof, "modulate", Color.WHITE, 0.5)
	return tween
