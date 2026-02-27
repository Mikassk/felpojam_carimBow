extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$label_config.modulate.a = 0
	$label_config.scale = Vector2(0,0)
	#$label_config.pivot_offset = Vector2(size.x/2,size.y/2)
	
	$label_intro.modulate.a = 0
	$label_intro.scale = Vector2(0,0)
	#$label_intro.pivot_offset = Vector2(size.x/2,size.y/2)
	
	$label_credit.modulate.a = 0
	$label_credit.scale = Vector2(0,0)
	#$label_credit.pivot_offset = Vector2(size.x/2,size.y/2)
	_active_label()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _active_label():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($label_intro,"modulate:a",1.0,0.6)
	tween.parallel().tween_property($label_intro,"scale",Vector2(1.0,1.0),0.6)
	tween.tween_property($label_config,"modulate:a",1.0,0.6)
	tween.parallel().tween_property($label_config,"scale",Vector2(1.0,1.0),0.6)
	tween.tween_property($label_credit,"modulate:a",1.0,0.6)
	tween.parallel().tween_property($label_credit,"scale",Vector2(1.0,1.0),0.6)
	
