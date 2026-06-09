extends Node2D

@onready var damage_timer: Timer = $Timer

var bodies_inside: Array = []

func _ready() -> void:
	damage_timer.wait_time = 1.0
	damage_timer.one_shot = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerController and not bodies_inside.has(body):
		bodies_inside.append(body)
		EventHandler.on_player_take_damage.emit(1)
		if damage_timer.is_stopped():
			damage_timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is PlayerController and bodies_inside.has(body):
		bodies_inside.erase(body)
	if bodies_inside.is_empty():
		damage_timer.stop()

func _on_timer_timeout() -> void:
	for body in bodies_inside.duplicate():
		if not is_instance_valid(body):
			bodies_inside.erase(body)
			continue
		if body is PlayerController:
			EventHandler.on_player_take_damage.emit(1)
	if bodies_inside.is_empty():
		damage_timer.stop()
