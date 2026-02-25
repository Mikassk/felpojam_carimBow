extends Control
var txt_name: String = ""
var txt_job: String = ""

@export var name_label: Label
@export var job_label: Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0;
	scale = Vector2(0.0,0.0)
	pivot_offset = Vector2(size.x/2.0,size.y/2.0)
	set_anchors_preset(Control.PRESET_CENTER)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func anim_text():
	name_label.text = str(txt_name)
	job_label.text = str(txt_job)
	
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	
	tween.tween_property(self,"modulate:a",1.0,0.7)
	tween.parallel().tween_property(self,"scale",Vector2(1.0,1.0),0.7)
	
	pass
	
