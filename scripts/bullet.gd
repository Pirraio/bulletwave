extends Area2D

@export var speed: float = 250.0
@export var damage: int = 1
var direction: Vector2
const RIGHT = Vector2.RIGHT

var is_from_enemy = false

func setup(dir: Vector2, is_from_enemy, speed=self.speed) -> void:
	direction = dir
	self.speed = speed
	self.is_from_enemy = is_from_enemy
	
func _physics_process(delta):
	# Mover a bullet na direção indicada
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass
	#queue_free()


func _on_body_entered(body):
	print(body)
	if body.is_in_group("enemy") and is_from_enemy:
		return
	if body.is_in_group("enemy") and !is_from_enemy:
		print("hit enemy")
		body.hurt(damage)
	if body.is_in_group("player") and is_from_enemy:
		print("hit")
		body.hurt(damage)
	queue_free()
	
	
