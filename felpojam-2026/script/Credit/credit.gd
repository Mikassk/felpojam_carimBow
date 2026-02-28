extends Control
@onready var labels_tree: Node = get_node("labels")
var names: Array = ["Aldévio de Oliveira Serra Neto", "Arthur Souza Vieira", "Gustavo de Oliveira Thur", "Monica Mika Sassaki", "Otavio Salvalaggio de Cordova","William Enzo Maeda"]
var jobs: Array = ["Sonorização e Revisão", "Ilustração da HQ da introdução e dos créditos","Programação","Programação, Game design e Produção","Testes e Qualidade","Ilustração"]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicScene.stop()
	MusicScene.stream = preload("res://AUDIO/musica-tela-inicial.wav")
	Fade.fade_out(0.0,0.5)
	await get_tree().create_timer(0.8).timeout
	MusicScene.play()
	spawn_names()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_names():
	for i in 6:
		var x_ = 0
		var y_ = -76
		var y_delta = 75
		var label_name = load("res://scenes/control_name.tscn")
		
		var create_label_name = label_name.instantiate()
		labels_tree.add_child(create_label_name)
		create_label_name.txt_name = names[i]
		create_label_name.txt_job = jobs[i]
		create_label_name.pos_x = x_
		create_label_name.pos_y = y_+(y_delta*i)
		create_label_name.anim_text()
		#create_label_name.pivot_offset = Vector2(scale.x/2, scale.y/2)
		#create_label_name.position = Vector2(x_,y_+(y_delta*i))
		await get_tree().create_timer(0.2).timeout
