extends Node2D

var speed = 400

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_bullet_area_body_entered(body):
	if body.is_in_group("enemies"):
		body.dead()
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
