extends CharacterBody2D

@export var speed: float = 100
@onready var anim = $AnimationPlayer
@onready var spawn_audio: AudioStreamPlayer2D = $spawnAudio

var player: CharacterBody2D
var can_follow = false

func _ready():
	anim.play("spawn")
	spawn_audio.play()
	start_follow_delay()

func start_follow_delay():
	await get_tree().create_timer(0.3).timeout
	can_follow = true
	anim.play("enemy")

func _physics_process(delta):
	if can_follow and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()

			if collider == player:
				player.take_damage()

func die():
	queue_free()
	
