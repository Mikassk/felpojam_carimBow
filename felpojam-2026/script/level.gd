extends Node2D

@onready var customer_tree: Node = get_node("customers")
@export var player: Node 
var customer_array: Array = []
var c_x: Array = [-11,-464,-805,-1333]
var c_y: Array = [-7,35,77,125]
var index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fade.fade_out(0.0,1.5)
	_on_load_customer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_load_customer():
	
	for i in 4:
		var rand = randi_range(0,3)
		var anim_name = "customer_idle"+str(rand)
		
		var customer_load = load("res://scenes/customer.tscn")
		var customer_ = customer_load.instantiate()
		customer_tree.add_child(customer_)
		customer_.position = Vector2(int(c_x[i]),int(c_y[i]))
		customer_.animate = rand
		customer_.create()
		customer_array.append(customer_)
	player.customer_ = customer_array[0]
	
	
