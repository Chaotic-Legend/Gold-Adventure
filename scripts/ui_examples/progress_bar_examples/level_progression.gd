extends HBoxContainer

@onready var progression_progress_bar: ProgressBar = %ProgressionProgressBar

func _process(delta: float) -> void:
	var current_x_pos: float = get_viewport().get_mouse_position().x
	var view_port_width: float = get_viewport_rect().size.x

	progression_progress_bar.value = remap(current_x_pos, 0, view_port_width, 0, progression_progress_bar.max_value)
