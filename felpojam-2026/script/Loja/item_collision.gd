extends Area2D

var item_parent: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_parent = get_parent()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT :
			#item_parent._change_text()
			pass
