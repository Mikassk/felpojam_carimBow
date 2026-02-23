extends Node2D

@onready var customer_tree: Node = get_node("customers")
@export var player: Node 
@export var timer: Node
@export var hud: Node
var customer_array: Array = []
var c_x: Array = [-11,-464,-805,-1333,-1333,-1333,-1333]
var c_y: Array = [100,100,100,100,100,100,100]
var index: int = 0
var current_customer: Array = [] #array com index dos npcs
var current_day: int = 1

var npc_index: Array = []
var current_npc_index: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fade.fade_out(0.0,1.5)
	hud.coin_animation_finished.connect(restart_day)
	
	_on_load_customer()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#spawna os cliente no começo da fase
func _on_load_customer():
	for i in 5:
		npc_index.append(i)
	npc_index.shuffle()
	for i in 7: #maximum customer
		#index aleatorio de 0->4
		
		var customer_load = load("res://scenes/customer.tscn")
		
		var create_customer_ = customer_load.instantiate()
		customer_tree.add_child(create_customer_)
		create_customer_.position = Vector2(int(c_x[i]),int(c_y[i]))
		
		create_customer_.pos = i
		#customer_.create()
		customer_array.append(create_customer_) #adiciona o npc
		current_customer.append(i) #adiciona a ordem do npc
		if i < 3:
			var current_index = npc_index[i] 
			print(current_index)
			create_customer_.index_sprite = current_index
			create_customer_.set_sprite()
			current_npc_index.append(current_index) #adiciona o index da sprite do npc  
		
	player.customer_ = customer_array[0]

func _next_customer():
	#atualizar o npc atual
	var index_previous = index
	index += 1
	if index >= customer_array.size(): 
		index = 0
	var act_customer = customer_array[index]
	player.customer_ = act_customer
	player.connect_customer()
	#fim atualizar o npc atual

	#randomizar o index e retirar os que ja estao em tela
	var array_index = []
	array_index.clear()
	for i in npc_index.size():
		var value = npc_index[i]
		var check_exists = false
		
		for j in current_npc_index.size():
			var current_value = current_npc_index[j]
			if value == current_value:
				check_exists = true
		
		if check_exists == false:
			array_index.append(value)
		
	array_index.sort()
	# alterar o index atual
	for i in customer_array.size(): 
		var value = current_customer[i]
		value+=1
		if value >= customer_array.size():
			value = 0
		current_customer[i] = value
	#identificar os npcs e mudar a posicao para a proxima do array
	for i in customer_array.size():
		var changed_index = current_customer[i]
		var new_customer = customer_array[changed_index]
		var x_ = c_x[i]
		var y_ = c_y[i]
		if i == 2:
			new_customer.index_sprite = array_index[0]
			new_customer.set_sprite()
		new_customer.change_position(x_,y_)
	
	
	
	var  customer_previous = customer_array[index_previous]
	customer_previous.change_balloon = true
	for i in 3:
		var npc_index = current_customer[i]
		var npc = customer_array[npc_index]
		current_npc_index[i] = npc.index_sprite
		
	
#clientes vao embora quando o tempo acaba
func _go_away():
	for i in customer_array.size():
		var changed_index = current_customer[i]
		var new_customer = customer_array[changed_index]
		var x_ = -1415
		var y_ = 126
		new_customer.final_position(x_,y_)
	
#reinicia a fase depois que acaba o tempo
func restart_day(): 
	current_day += 1
	Fade.fade_in(1.0,1.0)
	await get_tree().create_timer(2.0).timeout
	index = 0
	customer_array.clear()
	current_customer.clear()
	current_npc_index.clear()
	npc_index.clear()
	$stamp.play("stamp0")
	hud._restart_clock_hand(current_day)
	_on_load_customer()
	
	Fade.fade_out(0.0,2.0)
	timer._timer_start()
	player.can_pressed = true
