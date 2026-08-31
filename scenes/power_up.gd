extends Area2D
@export var type: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.hide()
	$Sprite2D2.hide()
	type = randi_range(1,2)
	if type == 1:
		$Sprite2D.show()
	if type == 2:
		$Sprite2D2.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_power_up"):
		body.get_power_up(type)
		queue_free()
