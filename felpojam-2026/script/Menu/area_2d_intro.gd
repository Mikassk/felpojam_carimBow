extends Area2D

var can_pressed: bool = true
var mousepressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if can_pressed && !mousepressed:
			mousepressed = true
			get_node("Menu/audio").play()
			change_scene()
		
func change_scene():
	
	await Fade.fade_in(1.0,0.8).finished
	scene_trigger.scene_load("intro")
	
func _on_mouse_entered():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"scale",Vector2(1.2, 1.2),0.5)
	

func _on_mouse_exited():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"scale",Vector2(1.0, 1.0),0.5)
