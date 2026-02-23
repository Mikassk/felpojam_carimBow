extends AnimatedSprite2D

var pos: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0
	pos = position.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func start_anim():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position:y",pos+20,0.7)
	tween.tween_callback(change_anim)

func change_anim():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position:y",pos,0.7)
	tween.tween_callback(start_anim)
