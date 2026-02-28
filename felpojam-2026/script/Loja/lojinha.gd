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
var win: bool = false

var no_spawn: bool = false
var ballon_spawned: bool = false

var tax: int
var price_total: int
var coins: int
var coin_day: int
var day: int

var tween: Tween
var create_item
var was_pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_out_music()
	$loja_background.modulate.a = 0
	randomize()
	
	item_btn.modulate.a = 0.0
	
	menu.scale = Vector2(1.0, 0.0)
	
	dialogue.modulate.a = 0.0
	dialogue.scale = Vector2(0.9, 0.0)
	
	await get_tree().create_timer(0.75).timeout
	if day < 2:
		tax = 100
		first_time = true
	else:
		tax = 100 + int(coin_day*0.2)
	_menu_spawn()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _menu_spawn():
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($loja_background, "modulate:a",0.3, 1.0)
	tween.tween_property($moço_malvado, "position:x",-626, 0.5)
	$audio_paper.play()
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
		
		create_item = item_load.instantiate();
		item_tree.add_child(create_item)
		item_tree.children_list.append(create_item)
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
		item_btn._unlock()

func _spawn_ballon():
	if obj_atual != obj_novo:
		obj_atual = obj_novo
		
		await get_tree().create_timer(0.1).timeout
		_fadeOut()
		
func _fadeIn():
	ballon_spawned = true
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
	
	if(ballon_spawned == true):
		tween = create_tween()
		
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		
		tween.tween_property(dialogue, "scale", Vector2(0.9,0.0), 0.5)
		await tween.parallel().tween_property(dialogue, "modulate:a", 0.0, 0.5).finished
		tween.kill()
	
	if no_spawn == false:
		_fadeIn()
	else:
		no_spawn = false
		ballon_spawned = false

func _update_text():
	if first_time == true:
		first_time = false
		label_name.text = ""
		label_text.position = Vector2(-842.0, -378.0)
		label_text.text = "Olá, meu caro! Todo dia vou passar aqui pra recolher a taxa do uso dos carimbos. \nAh, e antes que eu esqueça: também tenho uns itens que podem te interessar… se você quiser e puder pagar, claro."
	
	elif no_tax == true:
		no_tax = false
		MusicScene.stop()
		MusicScene.stream = preload("res://AUDIO/musica-gameover.ogg")
		label_name.text = ""
		label_text.position = Vector2(-842.0, -350.0)
		label_text.text = "Infelizmente você não conseguiu o dinheiro da taxa. Pegarei meus carimbos de volta."
		await get_tree().create_timer(3.0).timeout
		await Fade.fade_in(1.0,0.8).finished
		scene_trigger.scene_load("initial_screen")
		#_hud._reset_day()
		
	elif no_money == true:
		no_money = false
		label_name.text = ""
		label_text.position = Vector2(-842.0, -300.0)
		label_text.text = "Infelizmente você não tem dinheiro o suficiente para comprar isso."
		
		
	elif tax_pay == true:
		label_name.text = ""
		label_text.position = Vector2(-842.0, -250.0)
		label_text.text = "Obrigado pelo pagamento."
		label_text.autowrap_mode = TextServer.AUTOWRAP_OFF
		await get_tree().create_timer(2.0).timeout
		if(buy > -1):
			_hud.have_item[buy] = 1
		MusicScene.stop()
		MusicScene.stream = preload("res://AUDIO/musica-gameplay.ogg")
		_hud._reset_day()
		
	elif win == true:
		label_name.text = ""
		label_text.position = Vector2(-842.0, -350.0)
		label_text.text = "Parabéns. A dívida foi quitada.\nReceba o gato de volta. Caso aconteça novamente não o devolverei em condições tão satisfatórias."
		await get_tree().create_timer(7.0).timeout
		_hud._call_credit()
		
	else:
		label_name.text = obj_atual.item_name
		label_text.position = Vector2(-842.0, -280.0)
		label_text.text = obj_atual.item_text
	
func _check_pay():
	var final_price: int = tax + price_total
	
	if coins < tax:
		item_tree._block_btn()
		no_tax = true
		_fadeOut()
	
	elif coins < final_price:
		no_money = true
		item_btn._unlock()
		_fadeOut()
	
	else:
		item_tree._block_btn()
		_hud.coin -= final_price
		_hud._set_coin()
		if buy != 6:
			tax_pay = true
		else:
			win = true
		_fadeOut()

func fade_out_music():
	var tween = create_tween()
	tween.tween_property(MusicScene, "volume_db", -50,0.5)
	await tween.tween_callback(MusicScene.stop).finished
	MusicScene.volume_db = -5
	MusicScene.stream = preload("res://AUDIO/musica-shop.ogg")
	MusicScene.play()
