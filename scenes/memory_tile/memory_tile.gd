extends TextureButton

@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage

var _item_name: String

func _ready():
	pass
	
func get_item_name() -> String:
	return _item_name
	
func setup(image_data: Dictionary, frame_texture: CompressedTexture2D) -> void:
	frame_image.texture = frame_texture
	item_image.texture = image_data.item_texture
	_item_name = image_data.item_name
