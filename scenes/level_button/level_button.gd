extends TextureButton

@onready var label = $Label
@onready var sound = $Sound

var _level_number: int = 0

func _ready():
	label.text = "3x4"
	
func set_level_number(level_number: int) -> void:
	_level_number = level_number
	var level_data = GameManager.LEVELS[_level_number]
	label.text = "%sx%s" % [level_data.rows, level_data.columns]

func _on_pressed():
	SoundManager.play_button_click(sound)
