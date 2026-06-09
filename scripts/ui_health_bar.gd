extends ProgressBar

@export var start_hp: int = 10
@export var full_hp_color: Color
@export var empty_hp_color: Color
@export var outline_color: Color = Color.WHITE
@export var outline_width: float = 3.0
@export var death_reset_delay: float = 0.8

var stylebox: StyleBoxFlat
var is_dead = false

func _enter_tree() -> void:
	EventHandler.on_player_take_damage.connect(take_damage)

func _exit_tree() -> void:
	if EventHandler.on_player_take_damage.is_connected(take_damage):
		EventHandler.on_player_take_damage.disconnect(take_damage)

func _ready() -> void:
	stylebox = get_theme_stylebox("fill").duplicate()
	stylebox.border_width_left = 0
	stylebox.border_width_top = 0
	stylebox.border_width_right = 0
	stylebox.border_width_bottom = 0
	add_theme_stylebox_override("fill", stylebox)
	max_value = start_hp
	value = start_hp
	update_hp_bar()
	queue_redraw()

func take_damage(damage: int) -> void:
	if is_dead:
		return
	value = clamp(value - damage, 0, max_value)
	update_hp_bar()
	queue_redraw()
	var player = get_tree().get_first_node_in_group("player")
	if value > 0:
		if player and player.hurt_sound:
			player.hurt_sound.stop()
			player.hurt_sound.play()
		return
	is_dead = true
	if player and player.has_method("die"):
		player.die()
	await get_tree().create_timer(death_reset_delay).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()

func update_hp_bar() -> void:
	if max_value:
		stylebox.bg_color = lerp(empty_hp_color, full_hp_color, value / max_value)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), outline_color, false, outline_width)
