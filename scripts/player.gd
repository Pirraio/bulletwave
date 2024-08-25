extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

@export var speed = 300

const CROSSHAIR = preload("res://assets/sprites/crosshair.png")
var is_dodging = false


func _ready():
	Input.set_custom_mouse_cursor(CROSSHAIR, Input.CURSOR_ARROW, Vector2(16, 16))
	

func _physics_process(_delta):
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	var dodge = Input.is_action_pressed("dodge")
	
	if dodge && velocity != Vector2.ZERO:
		is_dodging = true
		print(is_dodging)
				
	if horizontal_direction:
		velocity.x = horizontal_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if vertical_direction:
		velocity.y = vertical_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
	
	if is_dodging == false:
		walking_animations(horizontal_direction, vertical_direction, is_dodging)
	else:
		animation.play("dodge")
	
	if horizontal_direction != 0:
		sprite.flip_h = (horizontal_direction == -1)
	
func walking_animations(horizontal_direction, vertical_direction, is_dodging):	
	if horizontal_direction == 0 && vertical_direction == 0 && is_dodging == false:
		animation.play("idle")
	if horizontal_direction != 0 || vertical_direction != 0 && is_dodging == false:
		animation.play("walk")
		
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dodge":
		is_dodging = false
		print(is_dodging)
		
