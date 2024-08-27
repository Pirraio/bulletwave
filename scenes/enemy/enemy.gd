extends Area2D

@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var rayCast = $RayCast2D
@onready var reloadTimer =  $RayCast2D/ReloadTimer

@export var fire_rate = 1 #shoots per second
@export var bullet_speed = 150
@export var speed = 10

var can_shoot = true

var velocity = Vector2()

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	follow_player(delta)
	if can_shoot:
		shoot()

func follow_player(delta):
	if Global.player != null:
		velocity = global_position.direction_to(Global.player.global_position)
	
	global_position += velocity * speed * delta

func shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	var direction = (Global.player.global_position - position).normalized()
	bullet.setup(direction, bullet_speed)
	bullet.position = self.global_position
	can_shoot = false
	reloadTimer.start()
	
	
func find_target():
	var new_target = null
	
	#if get_tree().has_group()


func _on_reload_timer_timeout() -> void:
	can_shoot = true
