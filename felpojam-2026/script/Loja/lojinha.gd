extends Node2D

@onready var menu: Sprite2D = get_node("loja_menu")
@onready var item_tree: Node = get_node("item_lojinha")
@onready var dialogue: Sprite2D = get_node("dialogue")

@onready var label_name: Label = get_node("item_name")
@onready var label_text: Label = get_node("item_text")

@onready var item_btn: Button = get_node("button_confirm")

var pos_x: Array = [-60, 275, 610]
var pos_y: int = -175

var obj_atual: Node = null
var obj_novo: Node = null
var item_list: Array = [0, 1, 2, 3, 4, 5]

var price_total: int = 0

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	item_btn.modulate.a = 0.0
	
	menu.scale = Vector2(1.0, 0.0)
	
	dialogue.modulate.a = 0.0
	dialogue.scale = Vector2(0.9, 0.0)
	
	item_list.shuffle()
	
	await get_tree().create_timer(0.75).timeout
	_menu_spawn()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _menu_spawn():
	tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	await tween.tween_property(menu, "scale", Vector2(1.0,1.0), 0.5).finished
	_item_spawn()

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
			create_item.spr_index = 6
			create_item._set_sprite()
		item_btn.modulate.a = 1.0
		item_btn.btnActive = true

func _spawn_ballon():
	if obj_atual == null:
		obj_atual = obj_novo
		
		_fadeIn()
		
	elif obj_atual != obj_novo:
		obj_atual = obj_novo
		
		label_name.text = ""
		label_text.text = ""
		await get_tree().create_timer(0.1).timeout
		_fadeOut()
		
func _fadeIn():
	tween = create_tween()
	
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(dialogue, "scale", Vector2(0.9,1.0), 0.5)
	await tween.parallel().tween_property(dialogue, "modulate:a", 1.0, 0.5).finished
	
	tween.kill()
	_update_text()

func _fadeOut():
	tween = create_tween()
	
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(dialogue, "scale", Vector2(0.9,0.0), 0.5)
	await tween.parallel().tween_property(dialogue, "modulate:a", 0.0, 0.5).finished
	
	tween.kill()
	_fadeIn()

func _update_text():
	label_name.text = obj_atual.item_name
	label_text.text = obj_atual.item_text
