extends Node

func parse_list(input: String) -> Array:
	var parsed = []
	for line in input.split("\n", false):
		if line.strip_edges() == "":
			continue
		var numbers = []
		for item in line.split(" ", true):
			numbers.append(int(item))
		parsed.append(numbers)
	return parsed

func is_report_safe(report: Array) -> bool:
	var direction = []
	for i in range(report.size() - 1):
		direction.append(report[i] - report[i + 1])
	
	var direction_set = {}
	for value in direction:
		direction_set[value] = true

	var positive_set = {1: true, 2: true, 3: true}
	var negative_set = {-1: true, -2: true, -3: true}

	var is_in_positive_set = true
	for key in direction_set.keys():
		if not positive_set.has(key):
			is_in_positive_set = false
			break

	var is_in_negative_set = true
	for key in direction_set.keys():
		if not negative_set.has(key):
			is_in_negative_set = false
			break

	return is_in_positive_set or is_in_negative_set

func part1(parsed: Array) -> int:
	return parsed.filter(is_report_safe).size()

func can_be_safe(report: Array) -> bool:
	if is_report_safe(report):
		return true
	for i in range(report.size()):
		var modified_report = report.duplicate()
		modified_report.remove_at(i)
		if is_report_safe(modified_report):
			return true
	return false

func part2(parsed: Array) -> int:
	return parsed.filter(can_be_safe).size()
