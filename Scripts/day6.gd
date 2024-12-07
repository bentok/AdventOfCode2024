extends Node

func parse_list(input: String) -> Dictionary:
	var lines = input.split("\n")
	var guard_position = null
	var obstacles = []
	var bounds = Vector2(lines[0].length(), lines.size())

	for y in range(lines.size()):
		var line = lines[y]
		for x in range(line.length()):
			if line[x] == "^":
				guard_position = Vector2(x, y)
			elif line[x] == "#":
				obstacles.append(Vector2(x, y))

	return {
		"guard": guard_position,
		"obstacles": obstacles,
		"bounds": bounds
	}

func turn_right(direction: Vector2) -> Vector2:
	if direction == Vector2(0, 1):
		return Vector2(-1, 0)
	elif direction == Vector2(-1, 0):
		return Vector2(0, -1)
	elif direction == Vector2(0, -1):
		return Vector2(1, 0)
	elif direction == Vector2(1, 0):
		return Vector2(0, 1)
	else:
		return Vector2()

func patrol(guard: Vector2, direction: Vector2, obstacles: Array, bounds: Vector2) -> Array:
	var path = []
	var current_position = guard
	var current_direction = direction

	while true:
		path.append(current_position)

		var next_position = current_position + current_direction

		if next_position.x < 0 or next_position.x >= bounds.x or next_position.y < 0 or next_position.y >= bounds.y:
			break

		if next_position in obstacles:
			current_direction = turn_right(current_direction)
		else:
			current_position = next_position

	return path

func causes_loop(guard: Vector2, direction: Vector2, obstacles: Array, bounds: Vector2) -> bool:
	var visited = {}
	var current_position = guard
	var current_direction = direction

	while true:
		var key = "%s:%s" % [current_position, current_direction]

		if visited.has(key):
			return true

		visited[key] = true

		var next_position = current_position + current_direction

		if next_position.x < 0 or next_position.x >= bounds.x or next_position.y < 0 or next_position.y >= bounds.y:
			break

		if next_position in obstacles:
			current_direction = turn_right(current_direction)
		else:
			current_position = next_position

	return false



func part1(parsed: Dictionary) -> int:
	var guard = parsed["guard"]
	var obstacles = parsed["obstacles"]
	var bounds = parsed["bounds"]

	var path = patrol(guard, Vector2(0, -1), obstacles, bounds)

	var unique_positions = {}
	for position in path:
		unique_positions[str(position)] = true

	return unique_positions.size()

func part2(parsed: Dictionary) -> int:
	var guard = parsed["guard"]
	var obstacles = parsed["obstacles"]
	var bounds = parsed["bounds"]

	var total = 0

	for y in range(bounds.y):
		for x in range(bounds.x):
			var potential_obstacle = Vector2(x, y)

			if potential_obstacle == guard or potential_obstacle in obstacles:
				continue

			var new_obstacles = obstacles.duplicate()
			new_obstacles.append(potential_obstacle)

			if causes_loop(guard, Vector2(0, -1), new_obstacles, bounds):
				total += 1

	return total
