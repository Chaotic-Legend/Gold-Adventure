extends HBoxContainer

@onready var stopwatch_toggle: Button = %StopwatchToggle
@onready var timer_text: Label = %TimerText

var is_timer_active: bool = false
var timer : float = 0.0

func _process(delta: float) -> void:
	if is_timer_active:
		timer += delta
		timer_text.text = str(snappedf(timer, 0.01))

func _on_stopwatch_toggle_toggled(toggled_on: bool) -> void:
	is_timer_active = toggled_on

	if toggled_on:
		stopwatch_toggle.text = "STOP"
		timer = 0.0
	else:
		stopwatch_toggle.text = "START"
