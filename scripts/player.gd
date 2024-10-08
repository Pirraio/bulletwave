extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer
@onready var weapon = $Weapon
@onready var weapon_sprite = $Weapon/Axis/Sprite2D
@onready var bullet_spawn_pos = $Weapon/Axis/Sprite2D/BulletSpawnPoint
@onready var dodge_sound = $DodgeSound
@onready var shot_sound = $Weapon/ShotSound
@onready var weapon_changer = $Weapon/Axis/WeaponChanger
@onready var reload_sound = $Weapon/ReloadSound
@onready var ammo_count = $HUD/AmmoCount

@onready var original_position = position #for shake
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
var game_over_screen = preload("res://scenes/game_over.tscn")

@export var speed = 100

var is_dodging: bool = false
var shotEnable:bool = true
const CROSSHAIR = preload("res://assets/sprites/crosshair.png")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		changeWeaponRotation(get_global_mouse_position())

func _ready() -> void:
	Input.set_custom_mouse_cursor(CROSSHAIR, Input.CURSOR_ARROW, Vector2(16, 16))
	Global.player = self
	
func is_player_dodging() -> bool:
	return is_dodging

func _exit_tree() -> void:
	Global.player = null


func _physics_process(_delta):
	var dir: Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	var dodge = Input.is_action_just_pressed("dodge")
	var reload_action = Input.is_action_just_pressed("reload")
	show_ammo(Global.magazine, Global.total_ammo)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if dodge && velocity != Vector2.ZERO:
		is_dodging = true
		
		if dir.x != 0:
			sprite.flip_h = (dir.x == -1)
		
	move_and_slide()

	if is_dodging == false:
		dodge_sound.play()
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
	
	if (reload_action):
		reload_press()
		
func walking_animations(horizontal_direction, vertical_direction, dodging):	
	if horizontal_direction == 0 && vertical_direction == 0 && dodging == false:
		animation.play("idle")
	if horizontal_direction != 0 || vertical_direction != 0 && dodging == false:
		animation.play("walk")
		
func shoot():
	if Global.total_ammo > 0 && shotEnable == true:
		#print(Global.total_ammo)
		#print(Global.magazine)
		shot_sound.play()
		var bullet = bullet_scene.instantiate()
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - position).normalized()
		bullet.setup(direction, false)
		bullet.position = bullet_spawn_pos.global_position
		self.get_parent().add_child(bullet)
		Global.magazine -= 1
		if Global.magazine <= 0 && Global.total_ammo > 0:
			shotEnable = false
			reload_sound.play()
			Global.total_ammo -= 6
			if Global.total_ammo < 0:
				Global.total_ammo == 0
			if Global.total_ammo >= 6:
				Global.magazine = 6
			else:
				Global.magazine = Global.total_ammo
			

				
func reload_press():
	if (Global.total_ammo - 6) > 0 && Global.magazine < 6:
		shotEnable = false
		reload_sound.play()
		Global.total_ammo = Global.total_ammo - (6 - Global.magazine)
		if Global.total_ammo >= 6:
			Global.magazine = 6
		else:
			Global.magazine = Global.total_ammo
	

func changeWeaponRotation(mouse_pos: Vector2):
	weapon.look_at(mouse_pos)
	if (weapon.global_rotation_degrees >= 90 and weapon.global_rotation_degrees <= 180) or (weapon.global_rotation_degrees <= -90 and weapon.global_rotation_degrees >= -180):
		weapon_sprite.scale = Vector2(weapon_sprite.scale.x, -abs(weapon_sprite.scale.y))
		return
	weapon_sprite.scale = Vector2(weapon_sprite.scale.x, abs(weapon_sprite.scale.y))

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dodge":
		is_dodging = false
		

func _on_reload_sound_finished():
	shotEnable = true

func show_ammo(magazine, total_ammo):
	var ammo_left = total_ammo - 6
	if magazine <= 0:
		magazine = 0
	if total_ammo <= 0 || ammo_left <= 0:
		ammo_left = 0
	ammo_count.text = str(magazine)
	ammo_count.text += "/"
	ammo_count.text += str(ammo_left)

func hurt(damage: int) -> void:
	
	Global.health -= damage
	flash_white_and_shake()
	if Global.health <= 0:
		call_deferred("game_over")
		
func game_over():
	get_tree().change_scene_to_packed(game_over_screen)
	
func flash_white_and_shake() -> void:
	sprite.modulate = Color(100, 1, 1)
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
		#await get_tree().process_frame #linha esta com bug que crasha o jogo ao morrer
		elapsed_time += get_process_delta_time()

	position = original_position 
