extends Control

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle()
	if Input.is_action_just_pressed("reset"):
		get_tree().paused = false
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func toggle() -> void:
	visible = !visible
	if visible:
		get_tree().paused = true
	else:
		get_tree().paused = false

func _on_resume_button_pressed() -> void:
	toggle()
