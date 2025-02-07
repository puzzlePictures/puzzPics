extends Node

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	
	$BackgroundColor.color = Color.SEA_GREEN
	
	for puzzle_idx in range(len(Puzzles.data)):
		var level_button := Button.new()
		
		level_button.custom_minimum_size = Vector2(screen_size.x * .7, 120)
		level_button.text = "Puzzle " + str(puzzle_idx + 1)
		level_button.add_theme_font_size_override("font_size", 60)
		level_button.add_theme_color_override("font_color", Color.DARK_ORANGE)
		level_button.pressed.connect(_on_level_select_clicked.bind(puzzle_idx))
		
		$VBoxContainer.add_child(level_button)

func _on_level_select_clicked(puzzle_idx: int) -> void:
	Puzzles.curr_puzzle_idx = puzzle_idx
	get_tree().change_scene_to_file("res://main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
