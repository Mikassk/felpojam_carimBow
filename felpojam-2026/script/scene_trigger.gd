extends Node

var scene_folder: String = "res://scenes/"

func scene_load(scene):
	var full_path = scene_folder + scene + ".tscn"
	var scene_tree = get_tree()
	scene_tree.change_scene_to_file(full_path)
