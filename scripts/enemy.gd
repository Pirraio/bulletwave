extends CharacterBody2D

@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var rayCast = $RayCast2D
@onready var reloadTimer =  $RayCast2D/ReloadTimer
@onready var sprite = $Sprite2D

@onready var original_position = position #for shake

@export var fire_rate = 1 #shoots per second
@export var bullet_speed = 100
@export var speed = 10



var can_shoot = true
var target = null

var health = 5

func _ready() -> void:
	target = find_target()

func _physics_process(delta: float) -> void:
	
	if target != null and rayCast.get_collider():
		var angle_to_target = global_position.direction_to(target.global_position).angle()
		rayCast.global_rotation = angle_to_target
		if rayCast.is_colliding() and rayCast.get_collider().is_in_group("player"):
			shoot()
			stop_movement()
	else:
		target = find_target()
	
	if rayCast.enabled:
		follow_player()

	global_position += velocity * speed * delta

func follow_player():
	if Global.player != null:
		velocity = global_position.direction_to(Global.player.global_position)
	
func stop_movement():
	print("stop")
	velocity = Vector2(0,0)

func shoot():
	rayCast.enabled = false
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	var direction = (Global.player.global_position - position).normalized()
	bullet.setup(direction, true, bullet_speed)
	bullet.position = self.global_position
	can_shoot = false
	reloadTimer.start()
	

func find_target():
	var new_target = null
	
	if get_tree().has_group("player"):
		new_target = get_tree().get_nodes_in_group("player")[0]
	return new_target


func _on_reload_timer_timeout() -> void:
	can_shoot = true
	rayCast.enabled = true


func hurt(damage):
	health -= damage
	flash_white_and_shake()
	if health <= 0:
		queue_free()
	
func flash_white_and_shake() -> void:
	sprite.modulate = Color(100, 100, 100)
	await shake()
	await get_tree().create_timer(0.05).timeout 
	sprite.modulate = Color(1, 1, 1, 1)


func shake() -> void:
	original_position = position
	var shake_magnitude = .5
	var shake_duration = 0.1
	var elapsed_time = 0.0

	while elapsed_time < shake_duration:
		var random_offset = Vector2(randf_range(-shake_magnitude, shake_magnitude), randf_range(-shake_magnitude, shake_magnitude))
		position = original_position + random_offset
		#await get_tree().process_frame
		elapsed_time += get_process_delta_time()

	position = original_position 
