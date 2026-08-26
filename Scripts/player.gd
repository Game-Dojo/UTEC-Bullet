extends CharacterBody2D

@onready var gun = $Gun
@onready var visual = $Visual
@onready var bullet_spawner = $Gun/BulletSpawner

const BULLET = preload("uid://ccjtkk6pof43q")
const SPEED = 200.0

var mouse_position := Vector2.ZERO

func _process(_delta):
	mouse_position = get_global_mouse_position()
	gun.look_at(mouse_position)
	
	# Girar el player hacia el mouse
	visual.flip_h = mouse_position.x < global_position.x
	
	if Input.is_action_just_pressed("fire"):
		#_recoil()
		_shoot()

func _physics_process(_delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))

	# Movimiento
	if direction:
		velocity = direction.normalized() * SPEED
		visual.play("Run")
	else:
		# Quieto
		visual.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _shoot():
	var bullet = BULLET.instantiate()
	bullet.transform = bullet_spawner.global_transform
	get_parent().add_child(bullet)

func _recoil():
	var dir = (global_position - mouse_position).normalized()
	var tw = create_tween().set_trans(Tween.TRANS_BACK)
	tw.tween_property(gun, "position", dir * 1.5, 0.1)
	tw.tween_property(gun, "position", -dir * 1.5, 0.1)
