extends Node2D
var timer_total:= 120

@export var timer_label: Label
@export var timer: Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	timer.start() # Start the timer
	_update_label()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	pass
	
func _on_Timer_timeout():
	if timer_total > 0:
		timer_total -= 1
		_update_label()
	else:
		timer.stop()
		

func _update_label():
	var min = timer_total/60
	var seg = timer_total % 60
	timer_label.text = "%02d:%02d" % [min, seg]
	
func _timer_is_over():
	pass
	
