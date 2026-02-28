extends Node2D
@export var spr: Sprite2D
@export var camera: Camera2D
var pos: int = 1

var p_x: Array = [431,426,-414,409,-403,425,-409]
var p_y: Array = [1689,616,616,-491,-485,-1603,-1597]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fade.fade_out(0.0,0.5)
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
	
	match pos:
		1:
			$audio.stream = preload("res://AUDIO/SFX/Intro/intro0.mp3")
		2:
			$audio.stream = preload("res://AUDIO/SFX/Intro/intro1.mp3")
		3:
			$audio.stream = preload("res://AUDIO/SFX/Intro/intro2.mp3")
		4:
			$audio.stream = preload("res://AUDIO/SFX/Intro/intro3.mp3")
		5:
			$audio.stream = preload("res://AUDIO/SFX/Intro/intro4.mp3")
		6:
			$audio.stream = preload("res://AUDIO/SFX/Intro/intro5.mp3")
	
	if pos > 0:
		$audio.play()
	pos += 1
	await get_tree().create_timer(5.0).timeout
	
	if pos < p_x.size():
		_move_image()
		
	else:
		await get_tree().create_timer(2.0).timeout
		await Fade.fade_in(1.0,0.8).finished
		scene_trigger.scene_load("level")
		MusicScene.stop()
		MusicScene.stream = preload("res://AUDIO/musica-gameplay.ogg")
		pass
	
	
	
