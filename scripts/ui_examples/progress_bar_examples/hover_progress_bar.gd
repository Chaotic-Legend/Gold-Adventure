extends ProgressBar

var is_hovered: bool = false
var filler: float = 0.0

func _enter_tree() -> void:
	mouse_entered.connect(toggle_hovered)
	mouse_exited.connect(toggle_hovered)

func _exit_tree() -> void:
	mouse_entered.disconnect(toggle_hovered)
	mouse_exited.disconnect(toggle_hovered)

func _process(delta: float) -> void:
	if is_hovered:
		filler = clampf(filler + delta, 0, max_value)
	else:
		filler = clampf(filler - delta, 0, max_value)

	value = filler

func toggle_hovered() -> void:
	is_hovered = !is_hovered
