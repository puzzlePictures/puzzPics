extends GridContainer

var puzzle_data: Dictionary = {}
var clues: Array[PackedByteArray] = []
var row_count: int = 10

var text_size: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puzzle_data = Puzzles.data[Puzzles.curr_puzzle_idx]
	clues.assign(puzzle_data["row_clues"])
	row_count = puzzle_data['rows']
	
	var col_count = puzzle_data['columns']
	text_size *= float(col_count) / abs(col_count - 3.5)
	
	var max_clue_len: int = clues.map( \
		func (clue_set: Array[int]) -> int: return len(str(clue_set.max()))).max()
	
	for row in row_count:
		var clue_set = RichTextLabel.new()
		clue_set.custom_minimum_size = Vector2(text_size * len(clues[row]), text_size)
		# push_[style]() methods add styling to BBCode text in label
		clue_set.push_font_size(text_size * 2 / 3)
		clue_set.push_bold()
		clue_set.push_color(Color.CRIMSON)
		
		# Create the string by iterating over the array and adding spaces where needed
		var clue_array: Array = clues[row]
		var clue_str: String = clue_array.reduce( \
			func (acc, clue) -> String: return acc + ' ' + str(clue).lpad(max_clue_len, '  '), '')
		# Align the text to the right
		clue_set.append_text("[right]" + clue_str + "[/right]")
		
		add_child(clue_set)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
