extends Panel

func _ready() -> void:
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color.TRANSPARENT
	add_theme_stylebox_override("panel", panel_style)
