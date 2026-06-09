class_name PlayerController
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var dash_sound = $DashSound
@onready var sword_sound = $SwordSound
@onready var hurt_sound = $HurtSound
@onready var death_sound = $DeathSound

@export var walk_speed = 150.0
@export var run_speed = 250.0
@export var jump_force = -400.0
@export var dash_speed = 650.0
@export var dash_max_distance = 300.0
@export var dash_curve: Curve
@export var dash_cooldown = 1.0
@export var ui_dash_cooldown: UIAbilityCooldown
@export_range(0, 1) var acceleration = 0.1
@export_range(0, 1) var deceleration = 0.1
@export_range(0, 1) var decelerate_on_jump_release = 0.5

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking = false
var attack_started_on_floor = false
var is_dashing = false
var dash_start_position = 0
var dash_direction = 0
var sprint_jump = false
var is_dead = false

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta):
	if is_dead:
		move_and_slide()
		return
	if !delta:
		return
	if is_on_floor():
		sprint_jump = false
	if not is_on_floor():
		velocity.y += gravity * delta
	var speed
	if is_on_floor() and Input.is_action_pressed("run"):
		speed = run_speed
	elif not is_on_floor() and sprint_jump:
		speed = run_speed
	else:
		speed = walk_speed
	var direction = Input.get_axis("left", "right")
	if is_attacking and is_on_floor() and not attack_started_on_floor:
		velocity.x = 0
		attack_started_on_floor = true
	if Input.is_action_just_pressed("attack") and not is_attacking and not is_dead:
		is_attacking = true
		attack_started_on_floor = is_on_floor()
		if attack_started_on_floor:
			velocity.x = 0
		if sword_sound:
			sword_sound.stop()
			sword_sound.play()
		if animated_sprite:
			animated_sprite.play("Attack")
			animated_sprite.frame = 0
	if direction:
		if not is_attacking:
			velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		elif attack_started_on_floor:
			velocity.x = 0
		animated_sprite.flip_h = direction == -1
		if is_on_floor() and not is_attacking:
			if Input.is_action_pressed("run"):
				animated_sprite.play("Run")
			else:
				animated_sprite.play("Walk")
	else:
		if not is_attacking:
			velocity.x = move_toward(velocity.x, 0, walk_speed * deceleration)
		elif attack_started_on_floor:
			velocity.x = 0
		if is_on_floor() and not is_attacking:
			animated_sprite.play("Idle")
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_wall()) and not attack_started_on_floor:
		sprint_jump = Input.is_action_pressed("run")
		velocity.y = jump_force
		if jump_sound:
			jump_sound.stop()
			jump_sound.play()
		if animated_sprite and not is_attacking:
			animated_sprite.play("Jump")
			animated_sprite.frame = 0
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release
	if Input.is_action_just_pressed("dash") and direction and not is_dashing and not is_attacking and not ui_dash_cooldown.is_on_cooldown():
		is_dashing = true
		dash_start_position = position.x
		dash_direction = direction
		if dash_sound:
			dash_sound.stop()
			dash_sound.play()
		animated_sprite.play("Dash")
		ui_dash_cooldown.set_cooldown(dash_cooldown)
	if is_dashing:
		var current_distance = abs(position.x - dash_start_position)
		if current_distance >= dash_max_distance or is_on_wall():
			is_dashing = false
		else:
			velocity.x = dash_direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance)
			velocity.y = 0
	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "Attack":
		is_attacking = false
		attack_started_on_floor = false
		if is_on_floor():
			if abs(velocity.x) > 5:
				if Input.is_action_pressed("run"):
					animated_sprite.play("Run")
				else:
					animated_sprite.play("Walk")
			else:
				animated_sprite.play("Idle")

func die():
	if is_dead:
		return
	is_dead = true
	velocity.x = 0
	visible = false
	if jump_sound:
		jump_sound.stop()
	if dash_sound:
		dash_sound.stop()
	if hurt_sound:
		hurt_sound.stop()
	if sword_sound:
		sword_sound.stop()
	if death_sound:
		death_sound.play()
