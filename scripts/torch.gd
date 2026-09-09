extends PointLight2D

@export var power: float = 0.55
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	energy = power
