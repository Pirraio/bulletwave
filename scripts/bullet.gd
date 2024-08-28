extends Area2D

@export var speed: float = 250.0
@export var damage: int = 1
var direction: Vector2

func setup(dir: Vector2, speed=self.speed) -> void:
	direction = dir
	self.speed = speed


func _ready() -> void:
	pass
	
func _physics_process(delta):
	# Mover a bullet na direção indicada
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	#if body.is_in_group("enemy"):
		#body.hurt(damage)
	#if body.is_in_group("player"):
		#body.hurt(damage)
	
	queue_free()
