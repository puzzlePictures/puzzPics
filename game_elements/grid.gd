extends GridContainer

signal puzzle_solved(funcToDisconnect)

# 2D array to store Cell node references
var cells: Array[Array] = [] 
# 2D array to store grid state (0: empty, 1: filled, 2: marked)
var grid_state: Array[PackedByteArray] = []
var filled_count: int = 0

var puzzle_data: Dictionary = {}
var solution: Array[PackedByteArray] = []
var solution_pixel_count: int = 50
var cols: int = 10
var rows: int = 10

# think about making the cell size dependent on the number of columns and rows
var cell_size: float = 50.0

func _ready() -> void:
	puzzle_data = Puzzles.data[Puzzles.curr_puzzle_idx]
	solution.assign(puzzle_data["solution"])
	solution_pixel_count = puzzle_data["total_pixel_count"]
	cols = puzzle_data['columns']
	rows = puzzle_data['rows']
	
	columns = cols
	position -= size / 2
	
	cell_size *= float(cols) / abs(cols - 3.5)
	
	# Populate grid_state with 0s
	for y in range(rows):
		grid_state.append(PackedByteArray())
		for x in range(cols):
			grid_state[y].append(0)
	
	# Populate cells with nodes
	for y in range(rows):
		cells.append(Array())
		for x in range(cols):
			var cell := Button.new()
			
			# Customize node
			cell.custom_minimum_size = Vector2(cell_size, cell_size)
			cell.button_down.connect(_on_cell_clicked.bind(x, y))
			cell.mouse_entered.connect(_on_cell_entered.bind(cell))
			#cell.focus_entered.connect(_on_cell_entered.bind(cell))
			cell.icon = preload("res://assets/cell_states/empty.svg")
			
			#cell.icon = preload("res://assets/cell_states/empty.svg") \
				#if puzzle_data['solution'][y][x] == 0 \
				#else preload("res://assets/cell_states/filled.svg")
				
			cell.expand_icon = true
			
			add_child(cell)
			cells[y].append(cell)
	
	get_child(0).grab_focus()

func _on_cell_clicked(col: int, row: int) -> void:
	# Toggle cell state
	if grid_state[row][col] == 0 and Input.is_action_pressed("mark_cell"):
		grid_state[row][col] = 2
		cells[row][col].icon = preload("res://assets/cell_states/marked.svg")
	elif grid_state[row][col] == 0:
		# Update count
		filled_count += 1
		
		grid_state[row][col] = 1
		cells[row][col].icon = preload("res://assets/cell_states/filled.svg")
	else:
		# Update count if the cell was filled before
		if grid_state[row][col] == 1: filled_count -= 1
		
		grid_state[row][col] = 0
		cells[row][col].icon = preload("res://assets/cell_states/empty.svg")
	
	# Check for win state
	if filled_count == solution_pixel_count:
		check_win_state()

func _on_cell_entered(cell: Button) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		cell.button_down.emit()

func check_win_state() -> void:
	for row in range(rows):
		for col in range(cols):
			if solution[row][col] == 1 and grid_state[row][col] != 1:
				return
			elif solution[row][col] == 0 and grid_state[row][col] == 1:
				return
	
	# If the loop completes without exiting early
	puzzle_solved.emit(cells[0][0].button_down.get_connections()[0]["callable"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
