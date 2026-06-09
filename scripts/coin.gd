extends Node2D

@onready var coin_sound = $CoinSound
@onready var animated_sprite = $AnimatedSprite2D
@onready var area_2d = $Area2D

var collected = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body is PlayerController:
		collected = true
		area_2d.set_deferred("monitoring", false)
		animated_sprite.visible = false
		coin_sound.play()
		EventHandler.on_collected.emit()

func _on_coin_sound_finished() -> void:
	queue_free()
