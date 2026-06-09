extends HBoxContainer

@onready var press_me_text: Label = %PressMeText

func _on_press_me_pressed() -> void:
	press_me_text.text = "Button was pressed!"
