class_name HealthBarExample

extends HBoxContainer

@export var max_health: float = 10.0
@export var full_hp_color: Color = Color.GREEN
@export var empty_hp_color: Color = Color.RED
@export var posion_dmg_per_sec: float = 3.0

@onready var health_progress_bar: ProgressBar = %HealthProgressBar

var health: float = 0.0
var stylebox: StyleBoxFlat

var is_posioned: bool = false

func _exit_tree() -> void:
	is_posioned = false

func _ready() -> void:
	stylebox = health_progress_bar.get_theme_stylebox("fill").duplicate() ## Default stylebox type is StyleBoxFlat
	health_progress_bar.add_theme_stylebox_override("fill", stylebox)

	health = max_health
	health_progress_bar.max_value = max_health
	health_progress_bar.value = max_health

	update_hp_bar()

func add_health(amount: float) -> void:
	health = clampf(health + amount, 0, max_health)
	health_progress_bar.value = health

	update_hp_bar()

func update_hp_bar() -> void:
	if health_progress_bar.max_value:
		stylebox.bg_color = lerp(empty_hp_color, full_hp_color, health_progress_bar.value / health_progress_bar.max_value)

func _on_heal_button_pressed() -> void:
	add_health(1)

	is_posioned = false

func _on_damage_button_pressed() -> void:
	add_health(-1)

func _on_poison_button_pressed() -> void:
	is_posioned = true

	while is_posioned:
		var current_time: int = Time.get_ticks_msec()
		await get_tree().process_frame
		var delta = (Time.get_ticks_msec() - current_time) * 0.001
		add_health(-delta * posion_dmg_per_sec)
