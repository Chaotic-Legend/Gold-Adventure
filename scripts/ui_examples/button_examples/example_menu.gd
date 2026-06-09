extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ui_examples/button_examples.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
