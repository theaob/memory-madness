extends Control

@export var level_button_scene: PackedScene

@onready var levels_container = $VBoxContainer/LevelsContainer

func _ready():
	setup_level_grid()

func create_level_button(level_number: int) -> void:
	var new_button = level_button_scene.instantiate()
	levels_container.add_child(new_button)
	new_button.set_level_number(level_number)

func setup_level_grid() -> void:
	for level in GameManager.LEVELS:
		create_level_button(level)
