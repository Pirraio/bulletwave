extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

@export var speed = 300

const CROSSHAIR = preload("res://assets/sprites/crosshair.png")
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var bullet_spawn_pos: Node2D = $Gun/Area2D/Sprite2D/BulletSpawnPoint
@onready var gun: Node2D = $Gun
@onready var gun_sprite: Sprite2D = $Gun/Area2D/Sprite2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		changeGunRotation(event.position)

func _ready():
	print("teste")
	Input.set_custom_mouse_cursor(CROSSHAIR, Input.CURSOR_ARROW, Vector2(16, 16))


func _physics_process(_delta):
	var dir: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	velocity = dir.normalized() * speed
	if Input.is_action_pressed("shoot"):
		shoot()
	move_and_slide()
	
	if dir.x != 0:
		sprite.flip_h = (dir.x == -1)
	update_animations(dir.x, dir.y)
	
	
func update_animations(horizontal_direction, vertical_direction):
	if horizontal_direction == 0 && vertical_direction == 0:
		animation.play("idle")
	else:
		animation.play("walk")
		
		
func shoot():
	var bullet = bullet_scene.instantiate()
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	
	bullet.setup(direction)
	bullet.position = bullet_spawn_pos.global_position
	self.get_parent().add_child(bullet)
	
func changeGunRotation(mouse_pos: Vector2):
	gun.look_at(mouse_pos)
	if (gun.global_rotation_degrees >= 90 and gun.global_rotation_degrees <= 180) or (gun.global_rotation_degrees <= -90 and gun.global_rotation_degrees >= -180):
		gun_sprite.scale = Vector2(gun_sprite.scale.x, -abs(gun_sprite.scale.y))
		return
	gun_sprite.scale = Vector2(gun_sprite.scale.x, abs(gun_sprite.scale.y))
