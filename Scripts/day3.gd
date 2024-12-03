extends Node

func _process_dos_and_donts(input: String, regex) -> Array:
	var result = []
	var allow_inclusion = true
	var i = 0
	# This makes me sad, but I'm doing it anyway 😥
	while i < input.length():
		if input.substr(i, 5) == "don't":
			allow_inclusion = false
			i += 5
		elif input.substr(i, 2) == "do":
			allow_inclusion = true
			i += 2
		else:
			var match = regex.search(input.substr(i))
			if match and match.get_start(0) == 0:
				if allow_inclusion:
					result.append([int(match.get_string(1)), int(match.get_string(2))])
				i += match.get_end(0)
			else:
				i += 1

	return result.duplicate()

var _accumulate_pairs = func(accum, val): return val[0] * val[1] + accum

func parse_list(input: String) -> Dictionary:
	var regex = RegEx.new()
	regex.compile(r"mul\((\d{1,3}),(\d{1,3})\)")

	var matches = regex.search_all(input)
	var list1 = matches.map(func(x): return [int(x.get_string(1)), int(x.get_string(2))])
	var list2 = _process_dos_and_donts(input, regex)

	return {"list1": list1, "list2": list2}

func part1(parsed: Dictionary) -> int:
	return parsed["list1"].reduce(_accumulate_pairs, 0)

func part2(parsed: Dictionary) -> int:
	return parsed["list2"].reduce(_accumulate_pairs, 0)
