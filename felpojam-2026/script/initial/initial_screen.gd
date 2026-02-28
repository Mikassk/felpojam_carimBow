extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicScene.stop()
	MusicScene.stream = preload("res://AUDIO/musica-tela-inicial.ogg")
	MusicScene.play()
	Fade.fade_out(0.0,0.5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
