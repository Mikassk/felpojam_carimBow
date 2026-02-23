extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_position(x_: int, y_: int):
	var time = randf_range(1.0,3.0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"position:x",x_,time)
	tween.parallel().tween_property(self,"position:y",y_,time)
	tween.set_trans(Tween.TRANS_SINE)
	await tween.tween_property(self,"scale",Vector2(0,0),0.3).finished
	#await get_tree().create_timer(1.0).timeout
	queue_free()
