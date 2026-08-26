extends CharacterBody2D

@onready var visuals: AnimatedSprite2D = $Visuals
@onready var body: CollisionShape2D = $CollisionShape2D

@onready var player: CharacterBody2D = $"../../Player"

var is_dead := false
const SPEED := 60

func _physics_process(_delta: float) -> void:
	if not is_dead:
		visuals.flip_h = global_position.x > player.global_position.x
		
		var movement = (player.global_position - global_position).normalized()
		velocity = movement * SPEED
		move_and_slide()

func dead() -> void:
	if not is_dead:
		is_dead = true
		visuals.play("Dead")
		body.set_deferred("disabled", true)
