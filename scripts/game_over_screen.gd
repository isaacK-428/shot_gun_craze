extends Control

var main_menu = preload("res://scenes/UI/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	cheese.start()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
