extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameWinModal.hide()
	
	var grid_size_vector = $Grid.get_minimum_size()
	
	## Use this for scale calcs
	#print(grid_size_vector)
	#print($ColumnClueContainer.get_minimum_size())
	#print($RowClueContainer.get_minimum_size())
	
	$BackgroundColor.color = Color.CADET_BLUE
	$GridBackLight.color = Color.DIM_GRAY
	
	$GridBackLight.size = grid_size_vector
	$GridBackLight.position -= $GridBackLight.size / 2
	
	$ColumnClueContainer.position.y -= (grid_size_vector.y / 2) + ($ColumnClueContainer.get_minimum_size().y / 2)
	$RowClueContainer.position.x -= (grid_size_vector.x / 2) + ($RowClueContainer.get_minimum_size().x / 2) + 10
	
	#print($Grid.position)
	#print($ColumnClueContainer.position)
	#print($RowClueContainer.position)
	
	$RowClueContainer.position.y += 5

func _puzzle_solved(funcToDisconnect: Callable) -> void:
	for row in range($Grid.rows):
		for col in range($Grid.cols):
			$Grid.cells[row][col].disabled = true
			
			if $Grid.cells[row][col].button_down.is_connected(funcToDisconnect):
				$Grid.cells[row][col].button_down.disconnect(funcToDisconnect)
	
	$GameWinModal.show()
	$BackButton.disabled = true

func _on_back_button_pressed() -> void: $BackConfirmationModal.show()

func _on_back_dialog_confirmed() -> void: get_tree().change_scene_to_file("res://level_select.tscn")

func _on_help_button_pressed() -> void: $HelpModal.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass
