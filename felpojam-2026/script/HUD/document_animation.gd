extends Sprite2D
var y_start: int = 755
var y_: int = 431
@export var stamp: AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_anim():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	await tween.tween_property(self,"position:y",y_,0.3).finished
	stamp.play("stamp0")
	position.y = y_start
	
func end_anim():
	position.y = y_start
