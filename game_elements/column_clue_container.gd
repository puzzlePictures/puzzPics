extends GridContainer

var puzzle_data: Dictionary = {}
var clues: Array[PackedByteArray] = []
var col_count: int = 10

var text_size: float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puzzle_data = Puzzles.data[Puzzles.curr_puzzle_idx]
	clues.assign(puzzle_data["column_clues"])
	col_count = puzzle_data['columns']
	
	columns = col_count
	
	text_size *= float(col_count) / abs(col_count - 3.5)
	
	# Find the longest set of clues; allows for "align-end" formatting later
	var max_clue_count: int = clues.map(func (clue_set) -> int: return len(clue_set)).max()
	
	for col in col_count:
		var clue_set = RichTextLabel.new()
		clue_set.custom_minimum_size = Vector2(text_size, text_size)
		# push_[style]() methods add styling to BBCode text in label
		clue_set.push_font_size(text_size * 2 / 3)
		clue_set.push_bold()
		clue_set.push_color(Color.BLUE)
		clue_set.fit_content = true
		clue_set.text_direction = Control.TEXT_DIRECTION_RTL
		
		var clue_array: PackedByteArray = clues[col]
		for idx in range(max_clue_count, 0, -1):
			# This addresses the variance in the number of clues in a column
			# Columns with a small amount of clues will get space filled in to be equivalent to the largest clue set
			idx = len(clue_array) - idx
			
			clue_set.append_text(str(clue_array[idx]) if idx >= 0 else '')
			clue_set.newline()
		
		add_child(clue_set)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
