extends Node2D
class_name customer
var tween: Tween
var key = ""
@onready var label_: Label = get_node("key")
@onready var anim: AnimatedSprite2D = get_node("animate_customer")
@export var anim_balloon: AnimatedSprite2D

var animate: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await rand_key()
	create()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func rand_key():
	var rand = randi_range(5,9)
	var frame_ = 0
	match rand:
		0:
			key = "key_1"
		1:
			key = "key_2"
		2:
			key = "key_3"
		3:
			key = "key_4"
		4:
			key = "key_5"
		5:
			key = "key_Q"
			frame_ = 0
		6:
			key = "key_W"
			frame_ = 1
		7:
			key = "key_E"
			frame_ = 2
		8:
			key = "key_R"
			frame_ = 3
		9:
			key = "key_T"
			frame_ = 4
	var str_ = key.replace("key_","")
	anim_balloon.frame = frame_
	#label_.text = ("press "+str_)

	pass

func positive_feedback():
	var positive = "customer_thumb"+str(animate)
	anim.play(positive)
	reset_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2(1.1,1.1),0.4)
	tween.tween_property(self,"scale",Vector2.ONE,0.4)
	
	
func negative_feedback():
	pass
	
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()

func create():
	var idle = "customer_idle"+str(animate)
	print(animate)
	anim.play(idle)
	
func change_position(x_: int, y_:int):
	reset_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position:x",x_,0.8)
	tween.tween_property(self,"position:y",y_,0.8)
	
	

	
	
