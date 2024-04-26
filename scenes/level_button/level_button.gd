extends TextureButton

@onready var label = $Label
@onready var sound = $Sound

var _level_number: int = 0

func _ready():
	label.text = "3x4"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
