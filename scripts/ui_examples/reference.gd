extends ReferenceRect

var entered: bool = false

func _enter_tree() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func _exit_tree() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)

func _ready() -> void:
	border_width = 3
	self_modulate.a = 0

func _process(delta: float) -> void:
	if entered:
		self_modulate.a = 1
	elif self_modulate.a > 0:
		self_modulate.a -= delta
	else:
		self_modulate.a = 0

func on_mouse_entered() -> void:
	entered = true

func on_mouse_exited() -> void:
	entered = false
