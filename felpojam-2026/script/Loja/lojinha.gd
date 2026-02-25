extends Node2D

@onready var item_tree: Node = get_node("item_lojinha")

var pos_x: Array = [-350, 150, 650];
var pos_y: int = -300;

var item_list: Array = [0, 1, 2, 3, 4]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	item_list.shuffle()
	_item_spawn()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _item_spawn():
	
	for i in 3:
		var item_load = load("res://scenes/item_loja.tscn")
		
		var create_item = item_load.instantiate();
		item_tree.add_child(create_item)
		create_item.position = Vector2(int(pos_x[i]), pos_y)
		create_item.item_index = i
		
		if i < 2:
			var current_sprite = item_list[i]
			
			create_item.spr_index = current_sprite
			create_item._set_sprite()
			
		else:
			create_item.spr_index = 5
			create_item._set_sprite()
