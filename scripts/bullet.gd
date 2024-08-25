extends Area2D

@export var speed: float = 500.0
@export var damage: int = 50
var direction: Vector2

func setup(dir: Vector2) -> void:
	direction = dir


func _ready() -> void:
	pass
	
	
func _physics_process(delta):
	# Mover a bullet na direção indicada
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	queue_free()
