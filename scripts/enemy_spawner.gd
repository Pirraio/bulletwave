extends Area2D

@onready var enemy_scene = preload("res://scenes/enemy/enemy.tscn")
@onready var spawn_timer = $SpawnTimer
@export var max_enemies = 10
@export var min_spawn_timer = 2
@export var max_spawn_timer = 10
var current_enemies = 0

func _ready() -> void:
	start_spawn_timer()

func start_spawn_timer() -> void:
	spawn_timer.wait_time = randf_range(min_spawn_timer, max_spawn_timer)
	spawn_timer.start()

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	current_enemies += 1
	print(position)
	print(enemy.position)
	print(Global.player.position)
	get_tree().current_scene.add_child(enemy)

func get_random_spawn_position() -> Vector2:
	var spawn_position = Vector2(randf_range(0, 1024), randf_range(0, 600))  # Adapte para seu cenário
	return spawn_position


func _on_spawn_timer_timeout() -> void:
	if current_enemies < max_enemies:
		spawn_enemy()
		start_spawn_timer()  # Reinicia o temporizador para o próximo spawn
