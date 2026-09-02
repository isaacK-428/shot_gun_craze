extends GPUParticles2D

var direction = Vector2.ZERO
var speed = 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position+= direction * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(67)


func _on_timer_timeout() -> void:
	queue_free()
