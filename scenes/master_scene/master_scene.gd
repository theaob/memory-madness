extends CanvasLayer

@onready var main_screen = $MainScreen
@onready var game_screen = $GameScreen
@onready var sound = $Sound

func _ready():
	_on_exit_pressed()
	SignalManager.exit_pressed.connect(_on_exit_pressed)
	SignalManager.level_selected.connect(_on_level_selected)

func show_game(_show: bool) -> void:
	game_screen.visible = _show
	main_screen.visible = !_show

func _on_exit_pressed():
	show_game(false)
	GameManager.clear_nodes_of_group(GameManager.TILE_GROUP)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)

func _on_level_selected(level: int): 
	show_game(true)
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)
