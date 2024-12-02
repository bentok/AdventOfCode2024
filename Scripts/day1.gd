extends Node

func parse_list(input: String) -> Dictionary:
	var lines = Utils.get_lines(input)
	var pairs = []
	
	for line in lines:
		var split_line = Utils.split(line, "   ")
		var int_pair = []
		for item in split_line:
			int_pair.append(int(item))
		pairs.append(int_pair)

	var transposed = Utils.transpose(pairs)
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
