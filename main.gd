extends Control

func _ready():
	var path = OS.get_executable_path().split("/")
	path.resize(path.size() - 1)
	path = "/".join(path)
	var paths = dir_contents(path)
	paths.reverse()
	
	make_button(paths.pop_front())
	
	for file in paths:
		make_button(file)
	

func _process(delta):
	$Versions/Newest.custom_minimum_size = Vector2.ONE * (size.y - 10)

func dir_contents(path) -> Array:
	var paths = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				paths.append_array(dir_contents(path + "/" + file_name))
			else:
				paths.append(path + "/" + file_name)
			file_name = dir.get_next()
		return paths
	else:
		print("An error occurred when trying to access the path.")
		return []

func make_button(path : String):
	if path.contains("Godot_v") and !path.contains("console"):
		if $Versions/Newest.get_child_count() == 0:
			$Versions/Newest.add_child(VersionButton.new(path))
		else:
			$Versions/Older.add_child(VersionButton.new(path))
