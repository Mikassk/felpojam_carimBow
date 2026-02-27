extends Node2D
@export var spr: Sprite2D
@export var camera: Camera2D
var pos: int = 1

var p_x: Array = [431,426,-414,409,-403,425,-409]
var p_y: Array = [1689,616,616,-491,-485,-1603,-1597]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spr.position.x = p_x[0]
	spr.position.y = p_y[0]
	await get_tree().create_timer(2.0).timeout
	_move_image()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _move_image():
	var x_ = p_x[pos]
	var y_ = p_y[pos]
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(spr,"position:x",x_,0.6)
	tween.parallel().tween_property(spr,"position:y",y_,0.6)
	pos += 1
	await get_tree().create_timer(2.0).timeout
	
	if pos < p_x.size():
		_move_image()
	else:
		pass
	
	
	
