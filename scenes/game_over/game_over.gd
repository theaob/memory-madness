extends Control

@onready var moves_taken_label = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/MovesTakenLabel

func _ready():
	SignalManager.game_over.connect(_on_game_over)

func _on_exit_button_pressed():
	hide()
	SignalManager.exit_pressed.emit()
	
func _on_game_over(moves: int) -> void:
	moves_taken_label.text = str(moves)
	show()
