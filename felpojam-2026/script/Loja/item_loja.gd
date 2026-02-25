extends Node2D
class_name item_loja

@onready var anim: AnimatedSprite2D = get_node("animate_item")

var item_parent: Node
var item_index: int = 0
var spr_index: int = 0

var item_name: String = ""
var item_text: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.modulate.a = 0.0
	anim.scale = Vector2(0.0, 0.0)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _set_sprite():
	item_parent = get_parent().get_parent()
	anim.frame = spr_index
	
	var tween = create_tween()
	
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(anim, "scale", Vector2(1.0,1.0), 0.8)
	tween.parallel().tween_property(anim, "modulate:a", 1.0, 0.8)
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT :
			item_parent.obj_atual = self
			item_parent._spawn_ballon()
			
func _set_text(index: int):
	match index:
		0:
			item_name = ""
			item_text = ""
