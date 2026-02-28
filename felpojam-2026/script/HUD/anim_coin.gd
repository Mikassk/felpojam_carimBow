extends Label
class_name anim_coin

var pos_y_initial: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0
	pos_y_initial = position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func animation():
	$audio_coin.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self,"modulate:a",1.0,0.5)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self,"position:y",pos_y_initial-40,0.7)
	tween.tween_property(self,"position:y",pos_y_initial,0.5)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(self,"modulate:a",1.0,0.5)
	tween.tween_property(self,"modulate:a",0.0,0.5)
	
