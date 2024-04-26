extends TextureButton

class_name MemoryTile

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var _item_name: String
var _can_be_selected: bool = true

func _ready():
	SignalManager.tile_selection_enabled.connect(_on_tile_selection_enabled)
	SignalManager.tile_selection_disabled.connect(_on_tile_selection_disabled)
	
func get_item_name() -> String:
	return _item_name
	
func reveal(_visible: bool) -> void:
	frame_image.visible = _visible
	item_image.visible = _visible
	
func setup(image_data: Dictionary, frame_texture: CompressedTexture2D) -> void:
	frame_image.texture = frame_texture
	item_image.texture = image_data.item_texture
	_item_name = image_data.item_name
	reveal(false)
	
func kill_on_success() -> void:
	z_index = 1
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation", deg_to_rad(720), 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self, "scale", Vector2(0, 0), 0)

func _on_tile_selection_enabled():
	_can_be_selected = true

func _on_tile_selection_disabled():
	_can_be_selected = false

func _on_pressed():
	if _can_be_selected == true:
		SignalManager.tile_selected.emit(self)
