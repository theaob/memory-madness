extends TextureRect

const SCALE_SMALL: Vector2 = Vector2(0.1, 0.1)
const SCALE_NORMAL: Vector2 = Vector2(1, 1)
const SCALE_TIME: float = 0.5

const SPIN_TIME_RANGE: Vector2 = Vector2(1.0, 2.0)

func _ready():
	tween_sprite()
	
func set_random_texture() -> void:
	texture = ImageManager.get_random_item_image().item_texture

func tween_sprite() -> void:
	var tween = get_tree().create_tween()
	tween.set_loops()
	tween.tween_callback(set_random_texture)
	tween.tween_property(self, "scale", SCALE_NORMAL, SCALE_TIME)
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	tween.tween_property(self, "rotation", get_random_rotation(), get_random_spin_time())
	tween.tween_property(self, "scale", SCALE_SMALL, SCALE_TIME)

func get_random_spin_time() -> float:
	return randf_range(SPIN_TIME_RANGE.x, SPIN_TIME_RANGE.y)

func get_random_rotation() -> float:
	return deg_to_rad(randf_range(-360, 360))
