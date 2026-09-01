extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("change_interest"):
		body.change_interest()
