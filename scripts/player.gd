extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var gun = $Gun
@onready var gun_sprite = $Gun/Axis/Sprite2D
@onready var bullet_spawn_pos = $Gun/Axis/Sprite2D/BulletSpawnPoint
@onready var bullet_scene = preload("res://scenes/bullet.tscn")

@export var speed = 300

var is_dodging: bool = false

const CROSSHAIR = preload("res://assets/sprites/crosshair.png")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		changeGunRotation(event.position)

func _ready():
	Input.set_custom_mouse_cursor(CROSSHAIR, Input.CURSOR_ARROW, Vector2(16, 16))
	

func _physics_process(_delta):
	var dir: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	var dodge = Input.is_action_just_pressed("dodge")
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	if dodge && velocity != Vector2.ZERO:
		print(velocity)
		is_dodging = true
		if dir.x != 0:
			sprite.flip_h = (dir.x == -1)
		
	move_and_slide()
	
	if is_dodging == false:
		if Input.is_action_just_pressed("shoot"):
			shoot()
		velocity = dir * speed
		walking_animations(dir.x, dir.y, is_dodging)

		if get_global_mouse_position().x > position.x:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		animation.play("dodge")
		
		
		
func walking_animations(horizontal_direction, vertical_direction, dodging):	
	if horizontal_direction == 0 && vertical_direction == 0 && dodging == false:
		animation.play("idle")
	if horizontal_direction != 0 || vertical_direction != 0 && dodging == false:
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
		
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dodge":
		is_dodging = false
		
