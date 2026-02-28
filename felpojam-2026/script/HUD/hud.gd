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

var coin: int = 1000 
var current_coin: int = 0
var combo: int = 0
var timer_total := 3
var timer_value = timer_total
var pos_y_coin_hud: float = 0.0
var pos_y_coin_table: float = 0.0
var frame_combo: int = 0
var day_id: int = 0

var create_loja
var have_item: Array = [0, 0, 0, 0, 0, 0]

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
	var check_active = have_item[4]
	var rand = randi_range(0,9)
	if value != 0:
		timer.stop()
		timer_value = timer_total
		timer.start()
		combo+=value
		anim_combo.text = ("x"+str(combo))
		animation_combo()
		check_combo()
	else:
		if check_active == 0:
			_end_combo()
			await get_tree().create_timer(0.3).timeout
			check_combo()
		else:
			if(rand != 0):
				_end_combo()
				await get_tree().create_timer(0.3).timeout
				check_combo()
			else:
				timer.stop()
				timer_value = timer_total
				timer.start()
				combo+=value
				anim_combo.text = ("x"+str(combo))
				animation_combo()
				check_combo()
	
func check_combo():
	frame_combo = 0
	if combo < 4:
		frame_combo = 0
	if combo >= 4 && combo < 8:
		frame_combo = 1
	if combo >= 8 && combo < 12:
		frame_combo = 2
	if combo >= 12 && combo < 18:
		frame_combo = 3
	if combo >= 18 && combo < 25:
		frame_combo = 4
	if combo >= 25:
		frame_combo = 5
	animation.frame = frame_combo

func add_coin(value: int):
	var check_active = have_item[0]
	var value_total = value+(2*frame_combo)
	if check_active == 1:
		value_total += value_total + int(value_total*0.05)
	anim_coin.text = ("+"+str(value_total))
	anim_coin.animation()
	current_coin += value_total

	
	animation_coin()
	var index_anim = 0
	
	if current_coin > 0 && current_coin< 50:
		index_anim = 1
	elif current_coin >= 50 && current_coin < 150:
		index_anim = 2
	elif current_coin >= 150 && current_coin < 400:
		index_anim = 3
	elif current_coin >= 400 && current_coin < 600:
		index_anim = 4
	elif current_coin >= 600:
		index_anim = 5
	var str_coin_table = "coin_table"+str(index_anim)
	coin_on_table.play(str_coin_table)
	
	anim_coin_table()
func add_current_coin_to_coin():
	var value = current_coin
	var check_active = have_item[1]
	if check_active == 1:
		value = value + int(value*0.2)
	var speed = 0.03
	if value > 150 && value < 350:
		speed = 0.01
	elif value >= 350 && value < 500:
		speed = 0.007
	elif value >= 500 && value < 800:
		speed = 0.001
	elif value >= 800:
		speed = 0.0005
		
	for i in value:
		coin+=1
		count_coin.text = (str(coin))
		await get_tree().create_timer(speed).timeout
		
	await get_tree().create_timer(1.0).timeout
	_create_lojinha()
	#emit_signal("coin_animation_finished")
	
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
	day_id = day
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
		_create_lojinha()
		
func _create_lojinha():
	var parent = get_parent().get_node("popup")
	var loja_load = load("res://scenes/lojinha.tscn")
	var aux_array: Array = []
	
	
	for i in 6:
		if have_item[i] == 0:
			aux_array.append(i)

	
	create_loja = loja_load.instantiate()
	parent.add_child(create_loja)
	create_loja.position = Vector2(960, 540)
	create_loja._hud = self
	print(create_loja._hud)
	create_loja.item_list = aux_array
	create_loja.coins = coin
	create_loja.coin_day = current_coin
	create_loja.day = day_id
	
	current_coin = 0
	
func _reset_day():
	create_loja.queue_free()
	level.restart_day()

func _set_coin():
	count_coin.text = str(coin)

	
