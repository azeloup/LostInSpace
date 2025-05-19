extends Control

@onready var label = $Panel/MarginContainer/VBoxContainer/Label
@onready var button = $Panel/MarginContainer/VBoxContainer/Button
@onready var button2 = $Panel/MarginContainer/VBoxContainer/Button2
@onready var score = $Panel2/MarginContainer/VBoxContainer/Label
@onready var panel_2 = $Panel2

const scene = preload("res://scene.tscn")
var game


func _ready():
	button.grab_focus()

func _on_button_pressed():
	var new_stylebox_normal = button.get_theme_stylebox("normal").duplicate()
	new_stylebox_normal.border_color = Color(1, 1, 0)
	var new_stylebox_hover = button.get_theme_stylebox("hover").duplicate()
	new_stylebox_hover.border_color = Color(1, 1, 0)

	button.add_theme_stylebox_override("normal", new_stylebox_normal)
	button.add_theme_stylebox_override("hover", new_stylebox_hover)

	label.add_theme_color_override("font_color", Color(1, 1, 0.5))
	
	button.release_focus()
	game = scene.instantiate()
	add_child(game)
	hide()


func _on_button2_pressed():
	var new_stylebox_normal = button2.get_theme_stylebox("normal").duplicate()
	new_stylebox_normal.border_color = Color(0, 1, 0.5)
	var new_stylebox_hover = button2.get_theme_stylebox("hover").duplicate()
	new_stylebox_hover.border_color = Color(0, 1, 0.5)

	button2.add_theme_stylebox_override("normal", new_stylebox_normal)
	button2.add_theme_stylebox_override("hover", new_stylebox_hover)

	label.add_theme_color_override("font_color", Color(0.5, 1, 0.75))
	
	get_tree().quit()


func end_game(x: int) -> void:
	score.text = "You lost!\nScore: %d" % x
	show()
	panel_2.show()
	remove_child(game)
	game.queue_free()
