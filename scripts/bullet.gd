extends Area2D

var speed = 50
var direction = null
var bullet_damage = 0.3
var active = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		if direction:
			position+=direction*speed*delta
	else:
		if !$Timer.time_left > 0.0:
			$Timer.start()
			$Sprite2D.hide()
func jump(amount,delta):
	for i in amount:
		position+=direction*speed*delta


func _on_body_entered(body: Node2D) -> void:
	if active:
		if has_overlapping_bodies():
			for i in get_overlapping_bodies():
				if body is TileMap or body is TileMapLayer:
					active = false
				if body.has_method("take_damage"):
					body.take_damage(bullet_damage)
					active = false
					return


func _on_timer_timeout() -> void:
	delete_bullet()
func delete_bullet():
	queue_free()
func take_damage():
	queue_free()
