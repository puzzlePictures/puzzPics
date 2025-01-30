extends GridContainer

var puzzle_data: Dictionary = {}
var clues: Array[PackedByteArray] = []
var cols: int = 10

const TEXT_SIZE = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puzzle_data = Puzzles.data[Puzzles.curr_puzzle_idx]
	clues.assign(puzzle_data["column_clues"])
	cols = puzzle_data['columns']
	
	columns = cols
	
	# Find the longest set of clues; allows for "align-end" formatting later
	var max_clue_count: int = clues.map(func (clue_set) -> int: return len(clue_set)).max()
	
	for col in range(cols):
		var clue_set = RichTextLabel.new()
		clue_set.custom_minimum_size = Vector2(TEXT_SIZE, TEXT_SIZE)
		# push_[style]() methods add styling to BBCode text in label
		clue_set.push_font_size(TEXT_SIZE * 2 / 3)
		clue_set.push_bold()
		clue_set.push_color(Color.CADET_BLUE)
		clue_set.fit_content = true
		clue_set.text_direction = Control.TEXT_DIRECTION_RTL
		
		var clue_array: PackedByteArray = clues[col]
		for idx in range(max_clue_count, 0, -1):
			# This addresses the variance in the number of clues in a column
			# Columns with a small amount of clues will get space filled in to be equivalent to the largest clue set
			clue_set.append_text(str(clue_array[len(clue_array) - idx]) if len(clue_array) - idx >= 0 else ' ')
			clue_set.newline()
		
		clue_set.size.y = -clue_set.size.y
		add_child(clue_set)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
