extends Node

const LEVELS: Dictionary = {
	1: { "rows": 2, "columns": 2 },
	2: { "rows": 3, "columns": 4 },
	3: { "rows": 4, "columns": 4 },
	4: { "rows": 4, "columns": 6 },
	5: { "rows": 5, "columns": 6 },
	6: { "rows": 6, "columns": 6 }
}

const TILE_GROUP = "tile"

func get_level_election(level_number: int) -> Dictionary:
	var level_data = LEVELS[level_number]
	var tile_count = level_data.rows * level_data.columns
	var target_pairs: int = tile_count / 2
	var selected_level_images = []
	
	ImageManager.shuffle_images()
	
	for i in range(target_pairs):
		selected_level_images.append(ImageManager.get_image(i))
		selected_level_images.append(ImageManager.get_image(i))

	selected_level_images.shuffle()
	
	return {
		"target_pairs": target_pairs,
		"column_number": level_data.columns,
		"image_list": selected_level_images
	}

func clear_nodes_of_group(group_name: String) -> void:
	for node in get_tree().get_nodes_in_group(group_name):
		node.queue_free()
		 
