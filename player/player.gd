extends CharacterBody2D

@onready var main: Node2D = $".."
@export var bullet_scene: PackedScene
@export var fire_rate: float = 0.3
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var can_shoot = true

const MOTION_SPEED = 160

func _physics_process(delta):
	var motion = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		motion.y -= 1
	if Input.is_action_pressed("move_bottom"):
		motion.y += 1
	if Input.is_action_pressed("move_left"):
		motion.x -= 1
	if Input.is_action_pressed("move_right"):
		motion.x += 1

	velocity = motion.normalized() * MOTION_SPEED
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is RigidBody2D or collider.is_in_group("pushable"):
			var push_dir = collision.get_normal() * -1
			collider.apply_central_impulse(push_dir * 200)

	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position

	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	bullet.direction = direction

	get_tree().current_scene.add_child(bullet)
	audio_stream_player_2d.play()
	can_shoot = false
	$AnimationPlayer.play("shoot")
	await get_tree().create_timer(0.2).timeout
	$AnimationPlayer.play("player")
	await get_tree().create_timer(fire_rate - 0.2).timeout
	can_shoot = true

func take_damage():
	main.game_over()
	can_shoot = false
