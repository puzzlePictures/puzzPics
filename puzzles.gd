extends Node

const DIR_PATH = "res://puzzle_data/"

var data: Array[Dictionary] = []
var curr_puzzle_idx: int = 0

func _ready() -> void:
	var dir: DirAccess = DirAccess.open(DIR_PATH)
	
	if dir:
		var dir_files: PackedStringArray = dir.get_files()
		
		for file_name: String in dir_files:
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				
				var file_path: String = DIR_PATH + file_name
				data.append(load_puzzle(file_path))
	else:
		print("An error occurred when trying to access the path.")
	pass

func load_puzzle(file_path: String) -> Dictionary:
	var puzzle_data_string = FileAccess.get_file_as_string(file_path)
	var puzzle_data = JSON.parse_string(puzzle_data_string)
	
	return puzzle_data

func count_solution_pixels(solution_matrix: Array) -> int:
	var pixel_count = 0
	
	# Convert each row to PackedByteArray via type hints
	for row: PackedByteArray in solution_matrix:
		# Now .count() is available! (it looks nicer than Array.reduce())
		pixel_count += row.count(1)
	
	print("Total pixel count: ", pixel_count)
	return pixel_count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
