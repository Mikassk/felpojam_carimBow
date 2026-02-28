extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Title.modulate.a = 0.0
	$Text.modulate.a  = 0.0
	$Confirm.modulate.a = 0.0
	$Background.scale.y = 0.0
	_anim_background()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _anim_background():
	$audio.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Background,"scale:y",0.8,0.6)
	tween.tween_property($Title,"modulate:a",1.0,0.8)
	tween.tween_property($Text,"modulate:a",1.0,0.8)
	await tween.tween_property($Confirm,"modulate:a",1.0,0.8).finished

	
