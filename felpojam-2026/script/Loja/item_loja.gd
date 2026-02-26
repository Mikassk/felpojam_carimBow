extends Node2D
class_name item_loja

@onready var price: Button = get_node("item_button")

@onready var anim: AnimatedSprite2D = get_node("animate_item")

var item_parent: Node
var item_index: int = 0
var spr_index: int = 0

var item_name: String = ""
var item_text: String = ""
var item_price: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.modulate.a = 0.0
	anim.scale = Vector2(0.0, 0.0)
	
	price.modulate.a = 0.0;
	price.size = Vector2(0.65, 0.0)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _set_sprite():
	item_parent = get_parent().get_parent()
	anim.frame = spr_index
	
	_set_text(spr_index)
	
	var tween = create_tween()
	
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(anim, "scale", Vector2(1.0,1.0), 0.8)
	await tween.parallel().tween_property(anim, "modulate:a", 1.0, 0.8).finished
	tween.kill()
	
	_show_price()
	
func _show_price():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(price, "scale", Vector2(0.65,0.65), 0.8)
	await tween.parallel().tween_property(price, "modulate:a", 1.0, 0.8).finished
	tween.kill()
	
	price.text = "$" + str(item_price) + ",00"
	
func _change_text():
	item_parent.obj_novo = self
	item_parent._spawn_ballon()
	
func _set_text(index: int):
	match index:
		0:
			item_name = "Cubo Estranho"
			item_text = "Seu dinheiro rende mais: todo valor recebido é aumentado em 5%."
			item_price = 600;
		1:
			item_name = "Gema Esquisita"
			item_text = "Ganhe um bônus de 20% sobre as moedas totais ganhadas no dia."
			item_price = 600;
		2:
			item_name = "Retrato do Gato"
			item_text = "Uma foto do seu gato, único efeito é te motivar mais."
			item_price = 250;
		3:
			item_name = "Lembrança Especial"
			item_text = "Algo que lembre seu gato, talvez te motive a trabalhar mais."
			item_price = 250;
		4:
			item_name = "Flor Bonita"
			item_text = "Ao errar, tem 10% de chance de manter o combo ativo."
			item_price = 800;
		5:
			item_name = "Ampulheta"
			item_text = "O dia tem 10% de chance de durar mais."
			item_price = 800;
		6:
			item_name = "Chave Especial"
			item_text = "A chave para ter seu gato de volta."
			item_price = 1000;
