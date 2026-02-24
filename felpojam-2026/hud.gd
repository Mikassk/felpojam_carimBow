extends Control
class_name hud

@export var count_coin: Label
@export var anim_coin: Label
@export var anim_combo: Label
@export var timer: Timer
@export var animation: AnimatedSprite2D
@export var anim_combo2: Label
@export var clock_hand: Sprite2D
@export var clock_day: Label
@export var coin_on_table: AnimatedSprite2D
@export var level: Node

var coin: int = 0 
var current_coin: int = 0
var combo: int = 0
var timer_total := 1
var timer_value = timer_total
var pos_y_coin_hud: float = 0.0
var pos_y_coin_table: float = 0.0

signal coin_animation_finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	count_coin.text = (str(coin))
	anim_combo.modulate.a = 0.0
	anim_combo2.modulate.a = 0.0
	animation.modulate.a = 0.0
	pos_y_coin_hud = $image_coin.position.y
	pos_y_coin_table = coin_on_table.position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func animation_coin():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property($image_coin,"position:y",pos_y_coin_hud+20,0.5)
	tween.tween_property($image_coin,"position:y",pos_y_coin_hud,0.5)
	
func animation_combo():
	var tween = create_tween()
	pivot_offset.y = size.y
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	if(anim_combo.modulate.a != 1.0):
		tween.tween_property($animation_combo,"modulate:a",1.0,0.4)
		tween.parallel().tween_property($anim_combo,"modulate:a",1.0,0.4)
		tween.parallel().tween_property($anim_combo2,"modulate:a",1.0,0.4)
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property($anim_combo,"scale",Vector2(1.2,1.2),0.4)
	tween.parallel().tween_property($anim_combo2,"scale",Vector2(1.2,1.2),0.4)
	tween.parallel().tween_property($animation_combo,"scale",Vector2(1.1,1.1),0.4)
	tween.tween_property($anim_combo,"scale",Vector2.ONE,0.4)
	tween.parallel().tween_property($anim_combo2,"scale",Vector2.ONE,0.4)
	tween.parallel().tween_property($animation_combo,"scale",Vector2.ONE,0.4)
	
	
func add_combo(value: int):
	if value != 0:
		timer.stop()
		timer_value = timer_total
		timer.start()
		combo+=value
		anim_combo.text = ("x"+str(combo))
		animation_combo()
		check_combo()
	else:
		_end_combo()
		await get_tree().create_timer(0.3).timeout
		check_combo()
		
	
	
func check_combo():
	if combo < 3:
		animation.frame = 0
	if combo >= 3 && combo < 6:
		animation.frame = 1
	if combo >= 6 && combo < 9:
		animation.frame = 2
	if combo >= 9 && combo < 12:
		animation.frame = 3
	if combo >= 12 && combo < 15:
		animation.frame = 4
	if combo >= 15:
		animation.frame = 5

func add_coin(value: int):
	anim_coin.text = ("+"+str(value+(2*(combo-1))))
	anim_coin.animation()
	current_coin += value + (2*combo)
	
	animation_coin()
	var index_anim = 0
	
	if current_coin > 0 && current_coin< 30:
		index_anim = 1
	elif current_coin >= 30 && current_coin < 150:
		index_anim = 2
	elif current_coin >= 150 && current_coin < 400:
		index_anim = 3
	elif current_coin >= 400 && current_coin < 1000:
		index_anim = 4
	elif current_coin >= 1000:
		index_anim = 5
	var str_coin_table = "coin_table"+str(index_anim)
	coin_on_table.play(str_coin_table)
	
	anim_coin_table()
func add_current_coin_to_coin():
	var speed = 0.03
	if current_coin > 150 && current_coin < 350:
		speed = 0.01
	elif current_coin >= 350 && current_coin < 500:
		speed = 0.007
	elif current_coin >= 500 && current_coin < 800:
		speed = 0.001
	elif current_coin >= 800:
		speed = 0.0005
		
	for i in current_coin:
		coin+=1
		count_coin.text = (str(coin))
		await get_tree().create_timer(speed).timeout
	current_coin = 0
	await get_tree().create_timer(2.0).timeout
	emit_signal("coin_animation_finished")
	
	
func _on_Timer_timeout():
	if timer_value > 1:
		timer_value -= 1
	else:
		timer.stop()
		_end_combo()
	pass

func _end_combo():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property($anim_combo,"modulate:a",0.0,0.3)
	tween.parallel().tween_property($animation_combo,"modulate:a",0.0,0.3)
	tween.parallel().tween_property($anim_combo2,"modulate:a",0.0,0.3)
	combo = 0

func _move_clock_hand(total_time: int):
	var alpha = 180/total_time
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	var angle = clock_hand.rotation_degrees - alpha
	tween.tween_property(clock_hand,"rotation_degrees",angle,0.5)
	#clock_hand.rotation_degrees -= alpha

func _restart_clock_hand(day: int):
	clock_day.text = "Dia "+str(day)
	clock_hand.rotation_degrees = 0
	coin_on_table.play("coin_table0")
	coin_on_table.modulate.a = 1.0
	$collision_area.can_pressed = false
	$collision_area.mousepressed = false
	

func anim_coin_table():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(coin_on_table,"position:y",pos_y_coin_table-20,0.5)
	tween.tween_property(coin_on_table,"position:y",pos_y_coin_table,0.5)
	
	
func _get_coins():
	if current_coin > 0:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_SINE)
		tween.tween_property($anim_get_coin,"modulate:a",1.0,0.5)
		$collision_area.can_pressed = true
	else:
		await get_tree().create_timer(0.5).timeout
		level.restart_day()
	

	
	
