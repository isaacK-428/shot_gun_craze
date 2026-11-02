extends Control
signal reset_score
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
	emit_signal("reset_score")
	cheese.click_sound()
	


func _on_main_menu_pressed() -> void:	
	get_tree().change_scene_to_packed(main_menu)
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
	cheese.click_sound()
func set_score(score: int,coins: int):
	$score.text = "score "+str(score)
	$coins.text = "coins gathered "+str(coins)
