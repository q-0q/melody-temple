extends Node

class_name CircularQueue

var arr
var head : int

func _init(size:int):
	arr = []
	arr.resize(size)
	arr.fill(Vector2.ZERO)
	head = 0

func insert(el):
	arr[head] = el
	head += 1
	if head == arr.size():
		head = 0

func get_min():
	var min = Vector2.ZERO
	for el in arr:
		if el.length_squared() >= min.length_squared():
			min = el
	return min
