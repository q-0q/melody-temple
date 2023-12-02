extends Node

class_name NoteReactor

@export var note_indeces : Array

func is_reacted():
	for el in note_indeces:
		if !Notes.note_is_played(el): return false
	return true

func has_bad_note():
	var i:int = 0	
	for el in Notes.bools:
		if el and i not in note_indeces:
			return true
		i+=1
	
func is_reacted_exclusive():
	if has_bad_note(): return false
	return is_reacted()

