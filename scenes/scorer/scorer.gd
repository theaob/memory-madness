extends Node

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

var _tiles: Array = []
var _selections: Array = []

var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0

func _ready():
	SignalManager.tile_selected.connect(_on_tile_selected)
	SignalManager.exit_pressed.connect(_on_exit_pressed)
	
func clear_new_game(target_pairs: int) -> void: 
	_selections.clear()
	_pairs_made = 0
	_moves_made = 0
	_target_pairs = target_pairs
	_tiles = get_tree().get_nodes_in_group(GameManager.TILE_GROUP)
 
func update_selections() -> void:
	reveal_timer.start()

func hide_selections() -> void:
	for selected_tile in _selections:
		selected_tile.reveal(false)

func check_pair_made(tile: MemoryTile) -> void:
	_selections.append(tile)
	tile.reveal(true)
	
	if _selections.size() != 2:
		return
		
	SignalManager.tile_selection_disabled.emit()
	_moves_made += 1
	
	update_selections()

func _on_tile_selected(tile: MemoryTile) -> void:
	SoundManager.play_tile_click(sound)
	
	check_pair_made(tile)

func _on_reveal_timer_timeout():
	hide_selections()
	_selections.clear()
	SignalManager.tile_selection_enabled.emit()
	
func _on_exit_pressed():
	reveal_timer.stop()
