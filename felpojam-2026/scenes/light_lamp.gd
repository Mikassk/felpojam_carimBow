extends Sprite2D
var tween: Tween
var light: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_light_()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	

	
	
func anim_light_():
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"modulate:a",0.7,1.5)
	tween.tween_callback(anim_light)
	
func anim_light():
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"modulate:a",1.0,2.5)
	tween.tween_callback(anim_light_)
	
func reset_tween():
	if tween:
		tween.kill()
	tween = create_tween()
	
	
