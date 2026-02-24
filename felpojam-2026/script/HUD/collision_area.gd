extends Area2D

var can_pressed: bool = false
var mousepressed: bool = false
var tween: Tween
@export var hand_anim: AnimatedSprite2D
@export var hud: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if can_pressed && !mousepressed:
			mousepressed = true
			
			start_anim()
			
func start_anim():
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property($coin_on_the_table,"scale",Vector2(1.2,1.2),0.4)
	tween.tween_property($coin_on_the_table,"scale",Vector2(1,1),0.4)
	tween.parallel().tween_property($coin_on_the_table,"modulate:a",0.0,0.4)
	tween.parallel().tween_property(hand_anim,"modulate:a",0.0,0.3)
	animation_coin_hud()
	
func animation_coin_hud():
	var rand = randi_range(10,30)
	for i in rand:
		var coin = load("res://scenes/coins.tscn")
		var create_coin = coin.instantiate()
		get_tree().current_scene.add_child(create_coin)
		create_coin.position = Vector2(480,331)
		var x_ = randi_range(-658,-692)
		var y_ = randi_range(-455,-447)
		create_coin.change_position(x_,y_)
	await get_tree().create_timer(0.5).timeout
	hud.add_current_coin_to_coin()
	
