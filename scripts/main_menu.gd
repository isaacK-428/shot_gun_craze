extends Control
var difficulty = 1
var active = preload("res://active.tres")
var normal = preload("res://normal.tres")
var normal_float = preload("res://normal_hover.tres")
var float_active = normal_float
#preload("res://active_float.tres")
var maps = [
	preload("res://scenes/main_scene.tscn")
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_visuals(difficulty)


func easy() -> void:
	difficulty = 1
	change_visuals(1)
func medium() -> void:
	difficulty = 2
	change_visuals(2)
func hard() -> void:
	difficulty = 3
	change_visuals(3)


func _on_button_2_pressed() -> void:
	print("settings")
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_play_random_pressed() -> void:
	if maps:
		cheese.difficulty = difficulty
		var scene = maps.pick_random()
		get_tree().change_scene_to_packed(scene)
func change_visuals(D):
	if D == 1:
		$difficulties/easy.add_theme_stylebox_override("normal", active)
		$difficulties/medium.add_theme_stylebox_override("normal", normal)
		$difficulties/hard.add_theme_stylebox_override("normal", normal)
		
		$difficulties/easy.add_theme_stylebox_override("hover", float_active)
		$difficulties/medium.add_theme_stylebox_override("hover", normal_float)
		$difficulties/hard.add_theme_stylebox_override("hover", normal_float)
	if D == 2:
		$difficulties/easy.add_theme_stylebox_override("normal", normal)
		$difficulties/medium.add_theme_stylebox_override("normal", active)
		$difficulties/hard.add_theme_stylebox_override("normal", normal)
		
		$difficulties/medium.add_theme_stylebox_override("hover", float_active)
		$difficulties/hard.add_theme_stylebox_override("hover", normal_float)
		$difficulties/easy.add_theme_stylebox_override("hover", normal_float)
	if D == 3:
		$difficulties/easy.add_theme_stylebox_override("normal", normal)
		$difficulties/medium.add_theme_stylebox_override("normal", normal)
		$difficulties/hard.add_theme_stylebox_override("normal", active)
		
		$difficulties/hard.add_theme_stylebox_override("hover", float_active)
		$difficulties/easy.add_theme_stylebox_override("hover", normal_float)
		$difficulties/medium.add_theme_stylebox_override("hover", normal_float)
