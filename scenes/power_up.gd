extends Area2D
@export var type: int = 1
@onready var strength: Sprite2D = $strength
@onready var health: Sprite2D = $health
@onready var health_light: PointLight2D = $health_light
@onready var strength_light: PointLight2D = $strength_light


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	strength.hide()
	health.hide()
	type = randi_range(1,2)
	var chance = randi_range(1,5)
	if chance == 1:
		health.show()
		type=1
		strength_light.queue_free()
		strength.queue_free()
		
	if chance >=2:
		strength.show()
		health_light.queue_free()
		health.queue_free()
		type=2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if strength:
		strength.rotate(delta*0.5)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_power_up"):
		body.get_power_up(type)
		queue_free()
