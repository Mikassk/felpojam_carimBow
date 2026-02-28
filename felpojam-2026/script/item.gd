extends Node2D

var array_object: Array = []
@export var level_control = Node
@export var hud = Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	array_object = [$Cubo,$Gema,$Retrato,$Lembranca,$Flor,$Ampulheta]
	for i in array_object.size():
		var obj = array_object[i]
		obj.modulate.a = 0.0
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _check_active():
	for i in array_object.size():
		var check_active = hud.have_item[i]
		var obj = array_object[i]
		if check_active == 1:
			active_item(obj)
	pass

func active_item(obj: Sprite2D):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(obj,"modulate:a",1.0,0.6)
