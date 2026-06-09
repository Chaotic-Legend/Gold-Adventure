extends HBoxContainer

@onready var basic_progress_bar: ProgressBar = %BasicProgressBar

func _on_left_button_pressed() -> void:
	basic_progress_bar.value -= 1

func _on_right_button_pressed() -> void:
	basic_progress_bar.value += 1
