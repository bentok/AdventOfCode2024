extends Control

func _ready():
	pass

func _process(delta):
	pass


func _on_open_file_button_pressed():
	$FileDialog.popup_centered()


func _on_file_dialog_file_selected(path):
	var file := FileAccess.open(path, FileAccess.ModeFlags.READ)
	if file:
		var content: String = file.get_as_text()
		process_input(content)
	else:
		print("File not found!")

func split(input: String, delimiter: String) -> Array:
	return input.split(delimiter)

func get_lines(input: String) -> Array:
	return input.split("\n", false)

func transpose(array: Array) -> Array:
	var transposed = []
	for i in range(array[0].size()):
		var column = []
		for row in array:
			column.append(row[i])
		transposed.append(column)
	return transposed

func parse_list(input: String) -> Dictionary:
	var lines = get_lines(input)
	var pairs = []
	
	for line in lines:
		var split_line = split(line, "   ")
		var int_pair = []
		for item in split_line:
			int_pair.append(int(item))
		pairs.append(int_pair)

	var transposed = transpose(pairs)
	var list1 = transposed[0]
	var list2 = transposed[1]

	return {"list1": list1, "list2": list2}
	
func part1(parsed: Dictionary) -> int:
	var list1 = parsed["list1"].duplicate()
	var list2 = parsed["list2"].duplicate()
	
	list1.sort()
	list2.sort()
	
	var total = 0
	for i in range(list1.size()):
		total += abs(list1[i] - list2[i])
	return total

func count_appearances(array: Array) -> Dictionary:
	var counts = {}
	for element in array:
		counts[element] = counts.get(element, 0) + 1
	return counts

func part2(parsed: Dictionary) -> int:
	var appearances = count_appearances(parsed["list2"])
	
	var total = 0
	for x in parsed["list1"]:
		total += x * appearances.get(x, 0)
	return total

func process_input(content: String):
	var lines = content.split("\n", false)
	var label := $Label
	if lines.size() > 0:
		var parsed = parse_list(content)
		var result1 = part1(parsed)
		var result2 = part2(parsed)
		label.text = "Part 1: %d\nPart 2: %d" % [result1, result2]
	else:
		label.text = "The file is empty."
