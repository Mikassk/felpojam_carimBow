extends Node2D
class_name item_loja

@onready var anim: AnimatedSprite2D = get_node("animate_item")

var item_index: int = 0
var spr_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _set_sprite():
	anim.frame = spr_index
