extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0
	animation_spawn()
	pass # Replace with function body.

func animation_spawn():
	pivot_offset.y = size.y
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self,"modulate:a",1.0,5)
	tween.parallel().tween_property(self,"scale.y",1.0,0.3)
	
	
