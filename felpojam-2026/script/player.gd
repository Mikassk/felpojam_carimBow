extends Node2D
class_name player

@onready var anim = get_node("AnimatedSprite2D")

@export var hud: Node
@export var customer_0: Node
@export var customer_1: Node
@export var customer_2: Node

var count_customer: int = 0
var customer_name: String = "customer0"


var error = 0


var was_pressed: bool = false
var key_pressed = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if was_pressed == false:
		check_button_pressed()
	else:
		if Input.is_action_just_pressed("key_space"):
			
			check_answer()
			was_pressed = false
	pass

func check_button_pressed():
	
	if Input.is_action_just_pressed("key_1"):
		print("1")
		key_pressed = "key_1"
		was_pressed = true
	if Input.is_action_just_pressed("key_2"):
		print("2")
		key_pressed = "key_2"
		was_pressed = true
	if Input.is_action_just_pressed("key_3"):
		print("3")
		key_pressed = "key_3"
		was_pressed = true
	if Input.is_action_just_pressed("key_4"):
		print("4")
		key_pressed = "key_4"
		was_pressed = true
	if Input.is_action_just_pressed("key_5"):
		print("5")
		key_pressed = "key_5"
		was_pressed = true
	if Input.is_action_just_pressed("key_6"):
		key_pressed = "key_6"
		was_pressed = true
	if Input.is_action_just_pressed("key_7"):
		key_pressed = "key_7"
		was_pressed = true
	if Input.is_action_just_pressed("key_8"):
		key_pressed = "key_8"
		was_pressed = true
	if Input.is_action_just_pressed("key_9"):
		key_pressed = "key_9"
		was_pressed = true
	if Input.is_action_just_pressed("key_0"):
		key_pressed = "key_0"
		was_pressed = true
	if Input.is_action_just_pressed("key_Q"):
		print("Q")
		key_pressed = "key_Q"
		was_pressed = true
	if Input.is_action_just_pressed("key_W"):
		print("W")
		key_pressed = "key_W"
		was_pressed = true
	if Input.is_action_just_pressed("key_E"):
		print("E")
		key_pressed = "key_E"
		was_pressed = true
	if Input.is_action_just_pressed("key_R"):
		print("R")
		key_pressed = "key_R"
		was_pressed = true
	if Input.is_action_just_pressed("key_T"):
		print("T")
		key_pressed = "key_T"
		was_pressed = true
	if Input.is_action_just_pressed("key_Y"):
		key_pressed = "key_Y"
		was_pressed = true
	if Input.is_action_just_pressed("key_U"):
		key_pressed = "key_U"
		was_pressed = true
	if Input.is_action_just_pressed("key_I"):
		key_pressed = "key_I"
		was_pressed = true
	if Input.is_action_just_pressed("key_O"):
		key_pressed = "key_O"
		was_pressed = true
	if Input.is_action_just_pressed("key_P"):
		key_pressed = "key_P"
		was_pressed = true
	if Input.is_action_just_pressed("key_A"):
		key_pressed = "key_A"
		was_pressed = true
	if Input.is_action_just_pressed("key_S"):
		key_pressed = "key_S"
		was_pressed = true
	if Input.is_action_just_pressed("key_D"):
		key_pressed = "key_D"
		was_pressed = true
	if Input.is_action_just_pressed("key_F"):
		key_pressed = "key_F"
		was_pressed = true
	if Input.is_action_just_pressed("key_G"):
		key_pressed = "key_G"
		was_pressed = true
	if Input.is_action_just_pressed("key_H"):
		key_pressed = "key_H"
		was_pressed = true
	if Input.is_action_just_pressed("key_J"):
		key_pressed = "key_J"
		was_pressed = true
	if Input.is_action_just_pressed("key_K"):
		key_pressed = "key_K"
		was_pressed = true
	if Input.is_action_just_pressed("key_L"):
		key_pressed = "key_L"
		was_pressed = true
	if Input.is_action_just_pressed("key_Ç"):
		key_pressed = "key_Ç"
		was_pressed = true
	if Input.is_action_just_pressed("key_Z"):
		key_pressed = "key_Z"
		was_pressed = true
	if Input.is_action_just_pressed("key_X"):
		key_pressed = "key_X"
		was_pressed = true
	if Input.is_action_just_pressed("key_C"):
		key_pressed = "key_C"
		was_pressed = true
	if Input.is_action_just_pressed("key_V"):
		key_pressed = "key_V"
		was_pressed = true
	if Input.is_action_just_pressed("key_B"):
		key_pressed = "key_B"
		was_pressed = true
	if Input.is_action_just_pressed("key_N"):
		key_pressed = "key_N"
		was_pressed = true
	if Input.is_action_just_pressed("key_M"):
		key_pressed = "key_M"
		was_pressed = true
	#if Input.is_anything_pressed():
		#key_pressed = "anything"
		#was_pressed = true

func check_answer():
	var correct_key = customer_0.get("key")
	var correct: bool = false
	
	if(correct_key == key_pressed):
		var total = 10
		var coin_ = 10 - error
		if coin_ <= 0:
			coin_ = 1
		correct = true
		hud.add_combo(1)
		hud.add_coin(coin_)
		customer_0.positive_feedback()
		customer_0.rand_key()
		error = 0
		anim.play("animation_stamp")

		
	else:
		hud.add_combo(0)
		error+=1
	key_pressed = ""
	print(correct)
	
	
