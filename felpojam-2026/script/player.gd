extends Node2D
class_name player

@onready var anim = get_node("AnimatedSprite2D")
@export var level_control: Node
@export var hud: Node
@export var stamp: AnimatedSprite2D
@export var document: Sprite2D
var customer_:Node2D = null
var indice_atual: int = 0
var count_customer: int = 0

var error = 0

var was_pressed: bool = false
var key_pressed = ""

var can_pressed: bool = true

var frame_: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if was_pressed == false:
		#check_button_pressed()
	#else:
		#if Input.is_action_just_pressed("key_space"):
			#
			#check_answer()
			#was_pressed = false
	#pass
	pass

func _input(event: InputEvent) -> void:
	if was_pressed == false:
		check_button_pressed()
	else:
		if Input.is_action_just_pressed("key_space"):
			
			check_answer()
			was_pressed = false
	pass

func check_button_pressed():
	
	if Input.is_action_just_pressed("key_1"):

		key_pressed = "key_1"
		was_pressed = true
	if Input.is_action_just_pressed("key_2"):

		key_pressed = "key_2"
		was_pressed = true
	if Input.is_action_just_pressed("key_3"):

		key_pressed = "key_3"
		was_pressed = true
	if Input.is_action_just_pressed("key_4"):

		key_pressed = "key_4"
		was_pressed = true
	if Input.is_action_just_pressed("key_5"):

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

		key_pressed = "key_Q"
		was_pressed = true
		frame_ = 1
	if Input.is_action_just_pressed("key_W"):
	
		key_pressed = "key_W"
		was_pressed = true
		frame_ = 2
	if Input.is_action_just_pressed("key_E"):
		
		key_pressed = "key_E"
		was_pressed = true
		frame_ = 3
	if Input.is_action_just_pressed("key_R"):
		
		key_pressed = "key_R"
		was_pressed = true
		frame_ = 4
	if Input.is_action_just_pressed("key_T"):
		
		key_pressed = "key_T"
		was_pressed = true
		frame_ = 5
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
	print(can_pressed)
	if can_pressed == true:
		var correct_key = customer_.get("key")
		var correct: bool = false
		
		if(correct_key == key_pressed):
			var total = 3
			var coin_ = 3 - error
			if coin_ <= 0:
				coin_ = 1
			correct = true
			hud.add_combo(1)
			hud.add_coin(coin_)
			customer_.positive_feedback()
			error = 0
			anim.frame = 0
			anim.play("hand_stamp")
			var anim_stamp = "stamp"+str(frame_)
			await get_tree().create_timer(0.4).timeout
			stamp.play(anim_stamp)
			document.start_anim()
			level_control._next_customer()
		else:
			hud.add_combo(0)
			error+=1
		key_pressed = ""

#func connect_customer():
	#customer_.customer_exited.connect(_on_customer_exited)
	#
#func _on_customer_exited():
	#can_pressed = false
	
