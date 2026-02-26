extends Button

@onready var select: Sprite2D = get_node("item_select")

var wasSelected: bool = false
var wasPressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select.modulate.a = 0.0
	
	button_up.connect(_on_button_up)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_up():
	if wasSelected == false:
		wasSelected = true
		select.modulate.a = 1.0
	else:
		wasSelected = false
		select.modulate.a = 0.0
	
