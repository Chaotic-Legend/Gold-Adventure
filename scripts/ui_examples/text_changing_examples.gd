extends Control

@onready var some_text: Label = %SomeText
@onready var counter_text: Label = %CounterText
@onready var mouse_x_text: Label = %MouseXText
@onready var mouse_y_text: Label = %MouseYText

var counter: int = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		some_text.text = "Some different text"

	if Input.is_action_just_pressed("ui_up"):
		counter += 1
		counter_text.text = str(counter)

	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	mouse_x_text.global_position.x = mouse_pos.x
	mouse_y_text.global_position.y = mouse_pos.y
	mouse_x_text.text = str("Mouse x: ", mouse_pos.x)
	mouse_y_text.text = str("Mouse y: ", mouse_pos.y)
