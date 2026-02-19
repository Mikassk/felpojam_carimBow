extends CanvasLayer
@export var fade_color: ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	fade_out(0.0,1.5)
	
func fade_in(target_alpha: float = 1.0, duration: float = 1.0):
	fade_color.color.a = 0.0
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_color,"color:a",target_alpha, duration)
	return tween
	
func fade_out(target_alpha: float = 0.0, duration: float = 1.0):
	fade_color.color.a = 1.0
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_color,"color:a",target_alpha, duration)
	return tween
