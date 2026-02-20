extends Node2D

@onready var customer_tree: Node = get_node("customers")
@export var player: Node 
var customer_array: Array = []
var c_x: Array = [-11,-464,-805,-1333,-1333,-1333,-1333,-1333,-1333]
var c_y: Array = [-7,35,77,125,125,125,125,125,125]
var index: int = 0
var current_customer: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fade.fade_out(0.0,1.5)
	_on_load_customer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_load_customer():
	
	for i in 9: #maximum customer
		var rand = randi_range(0,3) #types of character
		var anim_name = "customer_idle"+str(rand)
		
		var customer_load = load("res://scenes/customer.tscn")
		var customer_ = customer_load.instantiate()
		customer_tree.add_child(customer_)
		customer_.position = Vector2(int(c_x[i]),int(c_y[i]))
		customer_.animate = rand
		customer_.create()
		customer_array.append(customer_)
		current_customer.append(i)
	player.customer_ = customer_array[0]

func _next_customer():
	var index_previous = index
	index += 1
	if index >= customer_array.size():
		index = 0
	var act_customer = customer_array[index]
	player.customer_ = act_customer
	print(act_customer)
	for i in customer_array.size():
		var value = current_customer[i]
		value+=1
		if value >= customer_array.size():
			value = 0
		current_customer[i] = value
	for i in customer_array.size():
		var changed_index = current_customer[i]
		var new_customer = customer_array[changed_index]
		var x_ = c_x[i]
		var y_ = c_y[i]
		new_customer.change_position(x_,y_)
	
	var  customer_previous = customer_array[index_previous]
	await get_tree().create_timer(1.0).timeout
	customer_previous.rand_key()
	
