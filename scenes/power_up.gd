extends Area2D
@export var type: int = 1
@onready var health: Sprite2D = $health
@onready var strength: Sprite2D = $strength

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	strength.hide()
	health.hide()
	#type = randi_range(1,5)
	if type == 1:
		strength.show()
	if type >=2:
		health.show()
		type = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_power_up"):
		body.get_power_up(type)
		queue_free()
