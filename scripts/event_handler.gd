extends Node

signal on_collected
signal on_player_take_damage

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func collect():
	on_collected.emit()

func take_damage():
	on_player_take_damage.emit()
