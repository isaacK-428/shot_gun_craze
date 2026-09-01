extends Area2D
var explosion_area = preload("res://scenes/explosion_area.tscn")
var direction = Vector2.ZERO
var speed = 370
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position+=direction*speed*delta
	for i in$Area2D.get_overlapping_bodies():
		if i.is_in_group("player"):
			explode()
		


func _on_timer_timeout() -> void:
	explode()
func explode():
	var E_I = explosion_area.instantiate()
	E_I.global_position = global_position
	get_tree().root.add_child(E_I)
	queue_free()
