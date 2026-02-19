extends Button
var tween: Tween


func _ready() -> void:
	pivot_offset = size * Vector2(0.5,1.0)
	
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_button_down():
	if tween: tween.kill()
	
	scale = Vector2(0.9,0.7)

func _on_button_up():
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	
	tween.tween_property(self,"scale",Vector2(1,1),0.25)
	
	await Fade.fade_in(1.0,1.5).finished
	scene_trigger.scene_load("level")
	

	
