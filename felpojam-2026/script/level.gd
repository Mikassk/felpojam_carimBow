extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fade.fade_out(0.0,1.5)
	_on_load_customer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_load_customer():
	
	var rand = randi_range(0,3)
	var anim_name = "customer_idle"+str(rand)
	
	var customer_load = load("res://scenes/customer.tscn")
	var customer: Node = customer_load.instance()
	get_tree().root.call_deferred("add_child",customer)
	customer.position = Vector2(int(-11),int(-7))
	customer.animate = anim_name
	
