extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void: hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: pass

func _on_close_button_pressed() -> void: hide()
