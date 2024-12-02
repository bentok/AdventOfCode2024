extends Node

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
