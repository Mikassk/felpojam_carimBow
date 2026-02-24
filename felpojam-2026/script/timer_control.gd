extends Node2D
var timer_max:= 60
var timer_total = timer_max

@export var timer_label: Label
@export var timer: Timer
@export var level_control: Node
@export var hud: Node
@export var player: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	# # Start the timer
	_update_label()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	pass
	
func _on_Timer_timeout():
	if timer_total > 0:
		timer_total -= 1
		hud._move_clock_hand(timer_max)
		_update_label()
	else:
		timer.stop()
		_timer_is_over()
		

func _update_label():
	var min_ = timer_total/60
	var sec_ = timer_total % 60
	timer_label.text = "%02d:%02d" % [min_, sec_]
	
func _timer_is_over():
	player.can_pressed = false
	level_control._go_away()
	await get_tree().create_timer(1.0).timeout
	hud._get_coins()
	
	#level_control.restart_day()
	
func _timer_start():
	timer_total = timer_max
	timer.start()
	
