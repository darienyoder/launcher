extends Button

class_name VersionButton

var file : String

func _init(filepath : String):
	file = filepath
	text = file.split("Godot_v", false)[1].split("-stable_win64.exe", false)[0]

func _ready():
	pressed.connect(on_click)
	anchor_left = 0
	anchor_right = 1
	anchor_top = 0
	anchor_bottom = 1
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	if get_parent().name == "Newest":
		add_theme_font_size_override("font_size", 160)
	else:
		add_theme_font_size_override("font_size", 64)

func on_click():
	get_window().size = Vector2.ZERO
	get_window().position = Vector2(0, -1000)
	
	OS.execute(file, [])
	
	get_tree().quit()
