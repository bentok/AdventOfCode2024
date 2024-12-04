extends Node

var xmas = ["X", "M", "A", "S"]

func horizontal_lr(x, y, matrix):
	if x + 3 < matrix[y].length():
		var chars = []
		for i in range(4):
			chars.append(matrix[y][x + i])
		return chars == xmas
	return false

func horizontal_rl(x, y, matrix):
	if x - 3 >= 0:
		var chars = []
		for i in range(4):
			chars.append(matrix[y][x - i])
		return chars == xmas
	return false

func vertical_ud(x, y, matrix):
	if y + 3 < len(matrix):
		var chars = []
		for i in range(4):
			chars.append(matrix[y + i][x])
		return chars == xmas
	return false

func vertical_du(x, y, matrix):
	if y - 3 >= 0:
		var chars = []
		for i in range(4):
			chars.append(matrix[y - i][x])
		return chars == xmas
	return false

func diag_dr(x, y, matrix):
	if y + 3 < len(matrix) and x + 3 < matrix[y].length():
		var chars = []
		for i in range(4):
			chars.append(matrix[y + i][x + i])
		return chars == xmas
	return false

func diag_ur(x, y, matrix):
	if y - 3 >= 0 and x + 3 < matrix[y].length():
		var chars = []
		for i in range(4):
			chars.append(matrix[y - i][x + i])
		return chars == xmas
	return false

func diag_dl(x, y, matrix):
	if y + 3 < len(matrix) and x - 3 >= 0:
		var chars = []
		for i in range(4):
			chars.append(matrix[y + i][x - i])
		return chars == xmas
	return false

func diag_ul(x, y, matrix):
	if y - 3 >= 0 and x - 3 >= 0:
		var chars = []
		for i in range(4):
			chars.append(matrix[y - i][x - i])
		return chars == xmas
	return false

var mas = ["M", "A", "S"]
var sam = ["S", "A", "M"]

func is_intersect(x, y, matrix):
	if x == 0 or y == 0 or x == matrix[0].length() - 1 or y == len(matrix) - 1:
		return false

	var diag_right = []
	var diag_left = []
	for i in range(-1, 2):
		diag_right.append(matrix[y + i][x + i])
		diag_left.append(matrix[y + i][x - i])
	return (diag_right == mas or diag_right == sam) and (diag_left == mas or diag_left == sam)

func parse_list(input: String) -> Dictionary:
	var matrix = input.split("\n", false)
	return {"matrix": matrix}

func part1(parsed: Dictionary) -> int:
	var matrix = parsed["matrix"]
	var xs = []

	for y in range(len(matrix)):
		for x in range(matrix[y].length()):
			if matrix[y][x] == "X":
				xs.append([x, y])

	var count = 0
	for pos in xs:
		var x = pos[0]
		var y = pos[1]
		count += int(horizontal_lr(x, y, matrix))
		count += int(horizontal_rl(x, y, matrix))
		count += int(vertical_ud(x, y, matrix))
		count += int(vertical_du(x, y, matrix))
		count += int(diag_dr(x, y, matrix))
		count += int(diag_ur(x, y, matrix))
		count += int(diag_dl(x, y, matrix))
		count += int(diag_ul(x, y, matrix))
	return count

func part2(parsed: Dictionary) -> int:
	var matrix = parsed["matrix"]
	var a_positions = []

	for y in range(len(matrix)):
		for x in range(matrix[y].length()):
			if matrix[y][x] == "A":
				a_positions.append([x, y])

	var count = 0
	for pos in a_positions:
		var x = pos[0]
		var y = pos[1]
		count += int(is_intersect(x, y, matrix))
	return count
