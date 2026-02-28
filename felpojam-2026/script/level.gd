extends Node2D

@onready var customer_tree: Node = get_node("customers")
@onready var popup_tree: Node = get_node("popup")
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

var help_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicScene.stream = preload("res://AUDIO/musica-gameplay.ogg")
	MusicScene.play()
	Fade.fade_out(0.0,1.5)
	$day_texture.scale = Vector2(1,0)
	$day_name.modulate.a = 0.0
	hud.coin_animation_finished.connect(restart_day)
	#start_day()
	var help_screen_ = load("res://scenes/help_screen.tscn")
		
	help_screen = help_screen_.instantiate()
	popup_tree.add_child(help_screen)
	
	#_on_load_customer()
	
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
		create_customer_.position = Vector2(-1415,126)
		create_customer_.change_position(int(c_x[i]),int(c_y[i]),3.0) 
		create_customer_.pos = i
		#customer_.create()
		customer_array.append(create_customer_) #adiciona o npc
		current_customer.append(i) #adiciona a ordem do npc
		if i < 3:
			var current_index = npc_index[i] 
		
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
	if is_instance_valid(act_customer):
		player.customer_ = act_customer
		#player.connect_customer()
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
			#print(value)
		
	array_index.shuffle()
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
		new_customer.change_position(x_,y_,0.5)
	
	
	
	var  customer_previous = customer_array[index_previous]
	customer_previous.change_balloon = true
	customer_previous.change_alpha_balloon()
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
		new_customer.final = true
		new_customer.final_position(x_,y_)
	player.can_pressed = false
	$commands_paper.frame = 0
	
#reinicia a fase depois que acaba o tempo
func restart_day(): 
	
	current_day += 1
	Fade.fade_in(1.0,1.0)
	await get_tree().create_timer(2.0).timeout
	MusicScene.play()
	index = 0
	customer_array.clear()
	current_customer.clear()
	current_npc_index.clear()
	npc_index.clear()
	$item._check_active()
	$commands_paper.frame = 0
	$stamp.play("stamp0")
	$background.frame = 0
	hud._restart_clock_hand(current_day)
	start_day()
	
	Fade.fade_out(0.0,2.0)
	player.can_pressed = true

func start_day():
	var tween_day = create_tween()
	$day_name.text = "Dia "+str(current_day)
	tween_day.set_trans(Tween.TRANS_SINE)
	tween_day.set_ease(Tween.EASE_OUT)
	tween_day.tween_property($day_texture,"scale",Vector2(1,1),0.4)
	tween_day.tween_property($day_name,"modulate:a",1.0,0.4)
	
	await get_tree().create_timer(1.5).timeout
	tween_day.kill()
	tween_day = create_tween()
	tween_day.set_trans(Tween.TRANS_SINE)
	tween_day.set_ease(Tween.EASE_OUT)
	tween_day.tween_property($day_texture,"scale",Vector2(1,0),0.6)
	tween_day.parallel().tween_property($day_name,"modulate:a",0.0,0.6)
	await get_tree().create_timer(1.0).timeout
	_on_load_customer()
	await get_tree().create_timer(0.2).timeout
	timer._timer_start()
	
func change_bg():
	$background.frame = 1
	
func _set_frame_command(_frame:int):
	$commands_paper.frame = _frame

func _quit_help():
	help_screen.queue_free()
	await get_tree().create_timer(0.8).timeout
	start_day()
	
	
