extends CharacterBody2D

@export var speed: float = 100.0
@export var move_distance: float = 200.0
@export var start_moving_up: bool = true

var start_position: Vector2
var direction: Vector2
var top_limit: float
var bottom_limit: float

func _ready():
	start_position = global_position
	if start_moving_up:
		direction = Vector2.UP
		top_limit = start_position.y - move_distance
		bottom_limit = start_position.y
	else:
		direction = Vector2.DOWN
		top_limit = start_position.y
		bottom_limit = start_position.y + move_distance

func _physics_process(delta):
	global_position += direction * speed * delta

	if global_position.y <= top_limit:
		direction = Vector2.DOWN
	elif global_position.y >= bottom_limit:
		direction = Vector2.UP
