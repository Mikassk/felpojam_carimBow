extends Node2D

var children_list: Array = []
var btn_id: Button = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _reset_btn():
	btn_id.select.modulate.a = 0.0
	
func _block_btn():
	print("Chamado 1")
	var _aux = children_list.size()
	for i in _aux:
		var _btn = children_list[i]
		print(_btn)
		_btn.block_button()
