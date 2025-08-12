extends Area2D

@export var speed: float = 400
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta
	
	if not get_viewport_rect().has_point(global_position):
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.die()
		queue_free()
		
		var main = get_tree().get_first_node_in_group("main")
		if main:
			main.add_score()
