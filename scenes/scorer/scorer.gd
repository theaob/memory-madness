extends Node

class_name Scorer

@onready var sound = $Sound
@onready var reveal_timer = $RevealTimer

var _selections: Array = []

var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0

func _ready():
	SignalManager.tile_selected.connect(_on_tile_selected)
	SignalManager.exit_pressed.connect(_on_exit_pressed)
	
func get_moves_made() -> String:
	return str(_moves_made)
	
func get_pairs_made() -> String:
	return "%s / %s" % [ _pairs_made, _target_pairs ]
	
func clear_new_game(target_pairs: int) -> void: 
	_selections.clear()
	_pairs_made = 0
	_moves_made = 0
	_target_pairs = target_pairs
 
func are_selections_pair() -> bool:
	return (
		_selections[0].get_instance_id() != _selections[1].get_instance_id()
		and
		_selections[0].get_item_name() == _selections[1].get_item_name()
	)

func kill_tiles() -> void:
	for selected_tile in _selections:
		selected_tile.kill_on_success()
		
	_pairs_made += 1
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func update_selections() -> void:
	reveal_timer.start()
	if are_selections_pair() == true:
		kill_tiles()

func hide_selections() -> void:
	for selected_tile in _selections:
		selected_tile.reveal(false)
		
func check_game_over() -> void:
	if _pairs_made >= _target_pairs:
		SignalManager.game_over.emit(_moves_made)

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
	if are_selections_pair() == false:
		hide_selections()
		
	_selections.clear()
	
	check_game_over()
	
	SignalManager.tile_selection_enabled.emit()
	
func _on_exit_pressed():
	reveal_timer.stop()
