extends Node2D

@onready var crosshair: Sprite2D = $Crosshair
@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_points: Node2D = $SpawnPoints
@onready var enemies: Node2D = $Enemies

const ENEMY = preload("uid://bo8dc7oeakvau")

func _process(_delta: float) -> void:
	crosshair.global_position = get_global_mouse_position()

func _on_spawn_timer_timeout() -> void:
	spawn_timer.wait_time = randf_range(2,4)
	
	var enemy = ENEMY.instantiate()
	var random_point = spawn_points.get_children().pick_random()
	enemy.global_position = random_point.global_position
	enemies.add_child(enemy)
