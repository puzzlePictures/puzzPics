extends GridContainer

var cells = []  # 2D array to store ColorRect nodes
var grid_state = []  # 2D array to store grid state (0: empty, 1: filled)

const CELL_SIZE = 60
const COLS = 10
const ROWS = 10

func _ready() -> void:
	columns = COLS
	position -= size / 2
	
	# Initialize grid_state with "empty" states
	for y in range(ROWS):
		grid_state.append([])
		for x in range(COLS):
			grid_state[y].append(0)
	
	# Instantiate cells, set them to emptym and populate cells array
	for y in range(ROWS):
		cells.append([])
		for x in range(COLS):
			var cell = Button.new()
			cell.custom_minimum_size = Vector2(CELL_SIZE, CELL_SIZE) 
			cell.pressed.connect(_on_cell_clicked.bind(x, y))
			#cell.mouse_entered.connect(_on_cell_clicked.bind(x + (y * COLS)))
			cell.icon = preload("res://cell_states/empty.svg")
			cell.expand_icon = true
			
			add_child(cell)
			cells[y].append(cell)
	
	get_child(0).grab_focus()

func _on_cell_clicked(col: int, row: int) -> void:
	# Toggle cell state
	if (Input.is_action_pressed("mark_cell") or Input.is_action_pressed("mouse_mark_cell")) and grid_state[row][col] == 0:
		grid_state[row][col] = 2
		cells[row][col].icon = preload("res://cell_states/marked.svg")
	elif grid_state[row][col] == 0:
		grid_state[row][col] = 1
		cells[row][col].icon = preload("res://cell_states/filled.svg")
	else:
		grid_state[row][col] = 0
		cells[row][col].icon = preload("res://cell_states/empty.svg")

#func _on_Reset_pressed(): 
	## Reset grid state
	#for y in range(ROWS):
		#for x in range(COLS):
			#grid_state[y][x] = 0
#
	## Reset cell colors
	#for y in range(ROWS):
		#for x in range(COLS):
			#cells[y][x].icon = preload("res://cell_states/empty.svg") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
