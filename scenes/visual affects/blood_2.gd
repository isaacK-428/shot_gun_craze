extends Node2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var body: RigidBody2D = $RigidBody2D

var direction = Vector2.ZERO
var speed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed+= randi_range(-20,20)
	impulse.call_deferred()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if body:
		body.linear_velocity = body.linear_velocity.move_toward(Vector2(0.0,0.0),300*delta)
func impulse():
	body.apply_impulse(direction*speed,body.global_position)
func _process(delta: float) -> void:
	if body:
		sprite.position = body.position


func _on_timer_timeout() -> void:
	body.queue_free()
