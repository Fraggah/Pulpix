extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var spawn_acceleration: float = 0.02
@export var player: CharacterBody2D
@export var spawn_positions: Array[Vector2] = []

var is_game_over = false
var current_spawn_interval: float

func _ready():
	current_spawn_interval = spawn_interval
	$Timer.wait_time = current_spawn_interval
	$Timer.start()

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	if enemy_scene and player and not is_game_over:
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.player = player

		if spawn_positions.size() > 0:
			enemy_instance.global_position = spawn_positions[randi() % spawn_positions.size()]
		else:
			enemy_instance.global_position = global_position

		get_parent().add_child(enemy_instance)

		current_spawn_interval *= (1.0 - spawn_acceleration)
		$Timer.wait_time = max(current_spawn_interval, 0.1)

func game_over() -> void:
	is_game_over = true
