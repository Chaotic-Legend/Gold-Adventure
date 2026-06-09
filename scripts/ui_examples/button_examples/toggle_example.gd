extends HBoxContainer

@onready var toggle_me_text: Label = %ToggleMeText

func _on_toggle_me_toggled(toggled_on: bool) -> void:
	if toggled_on:
		toggle_me_text.text = "ON"
	else:
		toggle_me_text.text = "OFF"
