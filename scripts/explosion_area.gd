extends Area2D

var can_use = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	body.take_damage(2)


func _on_outer_area_body_entered(body: Node2D) -> void:
	body.take_damage(2)


func _on_timer_timeout() -> void:
	queue_free() 


func _on_start_timeout() -> void:
	can_use=true
