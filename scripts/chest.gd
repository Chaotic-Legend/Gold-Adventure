extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var chest_open = $ChestOpen
@onready var chest_close = $ChestClose

var player_in_range := false
var is_open := false
var busy := false

func _ready():
	is_open = false
	busy = false
	sprite.frame = 0
	sprite.stop()

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		toggle_chest()

func toggle_chest():
	if busy:
		return
	busy = true
	if !is_open:
		open_chest()
	else:
		close_chest()

func open_chest():
	is_open = true
	chest_open.play()
	sprite.play("Open")
	await sprite.animation_finished
	busy = false
	
func close_chest():
	is_open = false
	chest_close.play()
	sprite.play_backwards("Open")
	await sprite.animation_finished
	busy = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false
