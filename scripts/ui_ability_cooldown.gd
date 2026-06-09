class_name UIAbilityCooldown

extends TextureRect

@onready var progress_bar: ProgressBar = $ProgressBar

func _process(delta: float) -> void:
	if progress_bar.value > 0:
		progress_bar.value -= delta

func set_cooldown(cooldown: float) -> void:
	progress_bar.max_value = cooldown
	progress_bar.value = cooldown

func is_on_cooldown() -> bool:
	return progress_bar.value > 0
