extends Button
var tween: Tween

var btnActive: bool = false
var btnPressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pivot_offset = Vector2(size.x/2.0, size.y/2.0)
	
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_down():
	if btnActive == true:
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "rotation_degrees", 180, 0.1)

func _on_button_up():
	if btnPressed == true:
		tween.kill()
		
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		await tween.tween_property(self, "rotation_degrees", 360, 0.1).finished
		tween.kill()
