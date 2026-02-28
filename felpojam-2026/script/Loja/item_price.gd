extends Button

@onready var select: Sprite2D = get_node("item_select")

var item_parent: Node
var item_granpa: Node

var canPress: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select.modulate.a = 0.0
	
	button_up.connect(_on_button_up)
	item_parent = get_parent()
	item_granpa = item_parent.get_parent()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_up():
	if canPress:
		$audio_bt.play()
		if item_granpa.btn_id != self:
			if item_granpa.btn_id != null:
				item_granpa._reset_btn()
			
			item_granpa.btn_id = self
			select.modulate.a = 1.0
			item_parent._add_price()
			item_parent._change_text()
		else:
			item_granpa.btn_id = null
			select.modulate.a = 0.0
			item_parent._reset_price()
