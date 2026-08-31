extends RigidBody2D
@onready var sprite: Sprite2D = $Sprite2D

var direction = Vector2.ZERO
var speed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	speed+= randi_range(-20,20)
	apply_impulse(direction*speed,global_position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	linear_velocity = linear_velocity.move_toward(Vector2(0.0,0.0),300*delta)
