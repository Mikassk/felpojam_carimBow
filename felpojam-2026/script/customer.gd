extends Node2D
class_name customer
var tween: Tween

@onready var label_: Label = get_node("key")
@onready var anim: AnimatedSprite2D = get_node("animate_customer")
@export var anim_balloon: AnimatedSprite2D

signal customer_exited

var animate: int = 0
var last_animate: int = 0
var key = ""
var anim_thumb = "customer_thumb"+str(animate)
var anim_idle = "npc_idle"+str(animate)

var initiate: bool = false
var change_balloon: bool = false

var off_set_x: Array = [-200,80,80,30,30]
var off_set_y: Array = [20,150,80,80,0]

var current_npc_index: Array = []
var index_sprite: int

var pos: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rand_key()
	#rand_customer()
	#set_sprite()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#função do balão dos pedidos
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
	#var str_ = key.replace("key_","")
	var anim_frame = "balloon_icon"+str(frame_)
	anim_balloon.play(anim_frame)
	if initiate == false:
		initiate = true
	else:
		await get_tree().create_timer(0.5).timeout
		#rand_customer()
		set_sprite()
	#label_.text = ("press "+str_)



func positive_feedback():
	
	#anim.play(anim_thumb)
	tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale",Vector2(1.1,1.1),0.4)
	
	tween.tween_property(self,"scale",Vector2.ONE,0.4).set_delay(0.0)
	
	


	
func negative_feedback():
	pass
	
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()

func set_sprite():
	anim_idle = "npc_idle"+str(index_sprite)
	anim.play(anim_idle)
	var x_ = off_set_x[index_sprite]
	var y_ = off_set_y[index_sprite]
	anim.offset = Vector2(x_,y_)
	
func change_position(x_: int, y_:int):
	tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position:x",x_,0.7)
	tween.parallel().tween_property(self,"position:y",y_,0.7)
	await get_tree().create_timer(0.3).timeout
	if change_balloon:
		rand_key()
		change_balloon = false
	scale = Vector2.ONE
	
func final_position(x_: int, y_:int):
	emit_signal("customer_exited")
	var tween_ = create_tween()
	tween_.set_trans(Tween.TRANS_BACK)
	tween_.set_ease(Tween.EASE_IN_OUT)
	tween_.tween_property(self,"position:x",x_,1.0)
	await tween_.parallel().tween_property(self,"position:y",y_,1.0).finished
	queue_free()


	
	
