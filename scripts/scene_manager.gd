extends Node

func _enter_tree() -> void:
	EventHandler.on_player_death.connect(reload_scene_on_death)

func _exit_tree() -> void:
	EventHandler.on_player_death.disconnect(reload_scene_on_death)

func reload_scene_on_death() -> void:
	get_tree().reload_current_scene()
