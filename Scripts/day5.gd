extends Node

func sort_pages(rules: Dictionary, pages: Array) -> Array:
	var sorted_pages = pages.duplicate()
	var changed = true

	while changed:
		changed = false
		for i in range(sorted_pages.size() - 1):
			var a = sorted_pages[i]
			var b = sorted_pages[i + 1]
			if rules.has(b) and a in rules[b]:
				sorted_pages[i] = b
				sorted_pages[i + 1] = a
				changed = true

	return sorted_pages

func parse_list(input: String) -> Dictionary:
	var sections = input.split("\n\n")
	if sections.size() != 2:
		return {}

	var rules = {}
	for rule_line in sections[0].split("\n"):
		var pair = rule_line.split("|")
		if pair.size() == 2:
			var a = int(pair[0])
			var b = int(pair[1])
			if not rules.has(a):
				rules[a] = []
			rules[a].append(b)

	var updates = []
	for update_line in sections[1].split("\n"):
		var update = []
		for num in update_line.split(","):
			update.append(int(num))
		updates.append(update)

	return {"rules": rules, "updates": updates}


func part1(parsed: Dictionary) -> int:
	var rules = parsed["rules"]
	var updates = parsed["updates"]

	var total = 0
	for pages in updates:
		var sorted_pages = sort_pages(rules, pages)
		if pages == sorted_pages:
			total += pages[pages.size() / 2 as int]

	return total

func part2(parsed: Dictionary) -> int:
	var rules = parsed["rules"]
	var updates = parsed["updates"]

	var total = 0
	for pages in updates:
		var sorted_pages = sort_pages(rules, pages)
		if pages != sorted_pages:
			total += sorted_pages[sorted_pages.size() / 2 as int]

	return total
