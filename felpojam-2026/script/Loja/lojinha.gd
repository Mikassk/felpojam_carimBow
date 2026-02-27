extends Node2D

@onready var menu: Sprite2D = get_node("loja_menu")
@onready var item_tree: Node = get_node("item_lojinha")
@onready var dialogue: Sprite2D = get_node("dialogue")

@onready var label_name: Label = get_node("item_name")
@onready var label_text: Label = get_node("item_text")
@onready var label_tax: Label = get_node("tax_text")
@onready var label_loja: Label = get_node("loja_text")

@onready var item_btn: Button = get_node("button_confirm")

var _hud: Node

var pos_x: Array = [-60, 275, 610]
var pos_y: int = -175

var obj_atual: Node = null
var obj_novo: Node = null

var item_list: Array = [0, 1, 2, 3]
var item_count: int = 0

var buy: int = -1

var first_time: bool = false
var no_tax: bool = false
var no_money: bool = false
var tax_pay: bool = false

var tax: int = 0
var price_total: int = 0
var coins: int = 0
var coin_day: int = 0
var day: int = 0

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	tax = 50 + int(coin_day*0.2)
	
	item_btn.modulate.a = 0.0
	
	menu.scale = Vector2(1.0, 0.0)
	
	dialogue.modulate.a = 0.0
	dialogue.scale = Vector2(0.9, 0.0)
	
	if day < 2:
		first_time = true
	
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
	label_loja.text = "Escolha um item:"
	label_tax.text = "Taxa do dia = $" + str(tax)
	if first_time == true:
		_fadeIn()
	_item_spawn()

func _item_spawn():
	var _j: int
	item_count = item_list.size()
	item_list.shuffle()
	if item_count > 1:
		_j = 3
	elif item_count > 0:
		_j = 2
	else:
		_j = 1
	
	for i in _j:
		var item_load = load("res://scenes/item_loja.tscn")
		
		var create_item = item_load.instantiate();
		item_tree.add_child(create_item)
		create_item.position = Vector2(int(pos_x[i]), pos_y)
		create_item.item_index = i
		
		if i < (_j - 1):
			var current_sprite = item_list[i]
			
			create_item.spr_index = current_sprite
			create_item._set_sprite()
		else:
			create_item.spr_index = 6
			create_item._set_sprite()
		item_btn.modulate.a = 1.0
		item_btn.btnActive = true

func _spawn_ballon():
	if obj_atual != obj_novo:
		obj_atual = obj_novo
		
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
	label_name.text = ""
	label_text.text = ""
	
	tween = create_tween()
	
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(dialogue, "scale", Vector2(0.9,0.0), 0.5)
	await tween.parallel().tween_property(dialogue, "modulate:a", 0.0, 0.5).finished
	
	tween.kill()
	_fadeIn()

func _update_text():
	if first_time == true:
		first_time = false
		label_name.text = ""
		label_text.position = Vector2(-842.0, -460.0)
		label_text.text = "Olá meu caro, todo dia irei vir recolher uma taxa pelo uso dos carimbos.\nE antes que me esqueça, eu também tenho alguns itens que podem te interessar.\nCaso queira e possa pagar é claro."
	
	elif no_tax == true:
		no_tax = false
		label_name.text = ""
		label_text.position = Vector2(-842.0, -460.0)
		label_text.text = "Infelizmente você não conseguiu o dinheiro da taxa. Irei pegar meus carimbos de volta."
		await get_tree().create_timer(2.0).timeout
		print("game over")
		
	elif no_money == true:
		no_money = false
		label_name.text = ""
		label_text.position = Vector2(-842.0, -460.0)
		label_text.text = "Infelizmente você não tem dinheiro o suficiente para comprar isso."
		
	elif tax_pay == true:
		label_name.text = ""
		label_text.position = Vector2(-842.0, -460.0)
		label_text.text = "Obrigado pelo pagamento."
		await get_tree().create_timer(2.0).timeout
		if(buy > -1):
			_hud.have_item[buy] = 1
		_hud._reset_day()
	else:
		label_name.text = obj_atual.item_name
		label_text.position = Vector2(-842.0, -347.0)
		label_text.text = obj_atual.item_text
	
func _check_pay():
	var final_price: int = tax + price_total
	
	if coins < tax:
		no_tax = true
		_fadeOut()
	
	elif coins < final_price:
		no_money = true
		_fadeOut()
	
	else:
		tax_pay = true
		_fadeOut()
