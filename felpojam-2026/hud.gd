extends Control
class_name hud

@export var count_coin: Label
@export var anim_coin: Label
@export var anim_combo: Label
@export var spr_combo: Sprite2D

var coin: int = 0 
var combo: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	count_coin.text = (str(coin))
	anim_combo.modulate.a = 0.0
	spr_combo.modulate.a = 0.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func animation_coin():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property($image_coin,"position:y",20,0.5)
	tween.tween_property($image_coin,"position:y",1,0.5)
	
func animation_combo():
	var tween = create_tween()
	pivot_offset.y = size.y
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	if(anim_combo.modulate.a != 1.0):
		tween.tween_property($spr_combo,"modulate:a",1.0,0.4)
		tween.parallel().tween_property($anim_combo,"modulate:a",1.0,0.4)
	tween.parallel().tween_property($anim_combo,"scale",Vector2(1.2,1.2),0.4)
	tween.parallel().tween_property($spr_combo,"scale",Vector2(1.1,1.1),0.4)
	tween.tween_property($anim_combo,"scale",Vector2.ONE,0.4)
	tween.parallel().tween_property($spr_combo,"scale",Vector2.ONE,0.4)
	
	
func add_combo(value: int):
	if value != 0:
		combo+=value
		anim_combo.text = ("COMBO x"+str(combo))
		animation_combo()
	else:
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_SINE)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property($anim_combo,"modulate:a",0.0,0.3)
		tween.parallel().tween_property($spr_combo,"modulate:a",0.0,0.3)
		combo = 0
	

func add_coin(value: int):
	anim_coin.text = ("+"+str(value+(2*(combo-1))))
	anim_coin.animation()
	coin += value + (2*combo)
	count_coin.text = (str(coin))
	animation_coin()
