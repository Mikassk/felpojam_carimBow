extends Button
var tween: Tween

var item_parent: Node

var btnActive: bool = false
var btnPressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_parent = get_parent()
	pivot_offset = Vector2(size.x/2.0, size.y/2.0)
	
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_down():
	if btnActive == true:
		scale = Vector2(0.9,0.7)
		btnPressed = true

func _on_button_up():
	if btnPressed == true:
		tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_IN_OUT)
		await tween.tween_property(self,"scale",Vector2(1,1),0.25).finished
		tween.kill()
		
		item_parent._check_pay()
		
		btnPressed = false
