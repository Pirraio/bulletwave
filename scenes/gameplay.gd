extends Node2D

@export var isBilly: bool

func playerSetter(player: bool) -> void:
	isBilly = player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isBilly:
		var billy = preload("res://scenes/player_billy.tscn")
		var billy_instance = billy.instantiate()
		self.add_child(billy_instance)
	else:
		var caroline = preload("res://scenes/player_caroline.tscn")
		var caroline_instance = caroline.instantiate()
		self.add_child(caroline_instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
