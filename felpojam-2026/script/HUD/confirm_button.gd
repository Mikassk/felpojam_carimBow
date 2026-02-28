extends TextureButton
var tween: Tween
var parent_level

var canpress: bool = false
func _ready() -> void:
	parent_level = get_parent().get_parent().get_parent()
	pivot_offset = size * Vector2(0.5,0.5)
	
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	

func _on_button_down():
	if canpress == true:
		scale = Vector2(0.1,0.1)

func _on_button_up():
	if canpress == true:
		$audio_bt.play()
		tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_SPRING)
		
		tween.tween_property(self,"scale",Vector2(0.3,0.3),0.25)
		await get_tree().create_timer(0.6).timeout
		parent_level._quit_help()
	#await Fade.fade_in(1.0,1.5).finished
	#scene_trigger.scene_load("level")
	
	
	
