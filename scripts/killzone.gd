extends Area2D

@onready var timer = $Timer
@export var is_restarting = false

func _on_body_entered(body):
	if is_restarting:
		return
	if body is PlayerController:
		is_restarting = true
		if body.has_method("die"):
			body.die()
		EventHandler.on_player_take_damage.emit(999)
		timer.start()

func _on_timer_timeout():
	get_tree().paused = false
	get_tree().reload_current_scene()
