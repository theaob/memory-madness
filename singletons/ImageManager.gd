extends Node

var _item_images: Array = []

func _ready():
	load_item_images()
	
func add_file_to_list(filename: String, path: String) -> void:
	var full_path = path + "/" + filename
	
	var image_data = {
		"item_name": filename.rstrip(".png"),
		"item_texture": load(full_path)
	}
	
	_item_images.append(image_data)
	
func load_item_images() -> void:
	var path = "res://assets/glitch"
	var directory = DirAccess.open(path)
	
	if directory == null:
		print("Image directory not found.")
		return
		
	var files = directory.get_files()
	
	for file in files:
		if ".import" not in file:
			add_file_to_list(file, path)
			
	print("loaded images: ", _item_images.size())
	
func get_random_item_image() -> Dictionary:
	return _item_images.pick_random()
