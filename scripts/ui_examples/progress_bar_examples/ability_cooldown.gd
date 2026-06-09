extends ProgressBar

@export var ability_cooldown: float = 1.0

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect

var cooldown_timer: float = 0.0

func _ready() -> void:
	max_value = ability_cooldown

func _process(delta: float) -> void:
	if cooldown_timer > 0:
		cooldown_timer -= delta
	else:
		cooldown_timer = 0

	value = cooldown_timer

func _on_ability_button_pressed() -> void:
	if cooldown_timer <= 0:
		cooldown_timer = ability_cooldown
