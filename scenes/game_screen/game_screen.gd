extends Control

@export var memory_tile_scene: PackedScene

@onready var sound = $Sound
@onready var tile_container = $HBoxContainer/PlayContainer/TileContainer
@onready var scorer: Scorer = $Scorer

@onready var moves_label = $HBoxContainer/DetailContainer/VBoxContainer/HBoxContainer/MovesLabel
@onready var pairs_label = $HBoxContainer/DetailContainer/VBoxContainer/HBoxContainer2/PairsLabel

func _ready():
	SignalManager.level_selected.connect(_on_level_selected)
	
func _process(_delta):
	moves_label.text = scorer.get_moves_made()
	pairs_label.text = scorer.get_pairs_made()

func add_memory_tile(image: Dictionary, frame_image: CompressedTexture2D) -> void:
	var new_tile = memory_tile_scene.instantiate()
	tile_container.add_child(new_tile)
	new_tile.setup(image, frame_image)

func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.exit_pressed.emit()

func _on_level_selected(level: int):
	var level_selection = GameManager.get_level_election(level)
	var frame_image = ImageManager.get_random_frame_image()
	
	tile_container.columns = level_selection.column_number
	
	for image_dictionary in level_selection.image_list:
		add_memory_tile(image_dictionary, frame_image)
		
	scorer.clear_new_game(level_selection.target_pairs)
