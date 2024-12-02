extends Control

var current_day: int = 1
var day_scripts: Dictionary = {}

func _ready():
	for day in range(1, 24):
		var script_path = "res://Scripts/day%d.gd" % day
		if ResourceLoader.exists(script_path):
			day_scripts[day] = load(script_path)

	setup_day_buttons()

func _on_open_file_button_pressed():
	$FileDialog.popup_centered()

func _on_file_dialog_file_selected(path):
	var file := FileAccess.open(path, FileAccess.ModeFlags.READ)
	if file:
		var content: String = file.get_as_text()
		process_input(content)
	else:
		print("File not found!")

func process_input(content: String):
	if day_scripts.has(current_day):
		var day_logic = day_scripts[current_day].new()

		if day_logic.has_method("parse_list") and day_logic.has_method("part1") and day_logic.has_method("part2"):
			var parsed = day_logic.parse_list(content)
			var result1 = day_logic.part1(parsed)
			var result2 = day_logic.part2(parsed)
			$Label.text = "Day %d:\nPart 1: %d\nPart 2: %d" % [current_day, result1, result2]
		else:
			$Label.text = "Day %d logic is incomplete!" % current_day
	else:
		$Label.text = "No logic found for Day %d!" % current_day
 
func setup_day_buttons():
	var container = $DayButtonContainer
	for day in range(1, 26):
		var button = Button.new()
		button.text = "Day %d" % day
		button.connect("pressed", Callable(self, "_on_day_button_pressed").bind(day))
		container.add_child(button)

func _on_day_button_pressed(day: int):
	current_day = day
	print("Switched to Day %d" % current_day)
