extends Control
@onready var click: AudioStreamPlayer = $click

var difficulty = 1
var active = preload("res://themes/active.tres")
var normal = preload("res://themes/normal.tres")
var normal_float = preload("res://themes/normal_hover.tres")
var float_active = normal_float
var shop = preload("res://scenes/UI/shop.tscn")
var maps = [
	preload("res://scenes/maps/courtyard.tscn"),
	preload("res://scenes/maps/house_map.tscn"),
	preload("res://scenes/maps/harbour.tscn"),
	preload("res://scenes/maps/idk.tscn"),
	preload("res://scenes/maps/arena.tscn")	
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var deletes = get_tree().get_nodes_in_group("delete")
	#for i in deletes:
		#i.queue_free()		
	for i in deletes:
		# Only delete nodes in the "delete" group that are attached to the root
		if i.get_parent() == get_tree().root:
			i.queue_free()																																															


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_visuals(difficulty)


func easy() -> void:
	click_sound()
	difficulty = 1
	change_visuals(1)
func medium() -> void:
	click_sound()
	difficulty = 2
	change_visuals(2)
func hard() -> void:
	click_sound()
	difficulty = 3
	change_visuals(3)


func _on_button_2_pressed() -> void:
	click_sound()
	print("settings")
	get_tree().change_scene_to_file("res://scenes/UI/settings.tscn")


func _on_play_random_pressed() -> void:
	click_sound()
	if maps:
		cheese.difficulty = difficulty
		var scene = maps.pick_random()
		play_now()
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


func _on_house_pressed() -> void:
	play_now()
	get_tree().change_scene_to_packed(maps[1])
	click_sound()



func _on_courtyard_pressed() -> void:
	play_now()
	get_tree().change_scene_to_packed(maps[0])
	click_sound()


func _on_docks_pressed() -> void:
	play_now()
	get_tree().change_scene_to_packed(maps[2])
	click_sound()
func play_now():
	pass
		


func _on_cave_pressed() -> void:
	play_now()
	get_tree().change_scene_to_packed(maps[3])
	click_sound()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(shop)
	click_sound()


func _on_arena_pressed() -> void:
	play_now()
	get_tree().change_scene_to_packed(maps[4])
	click_sound()
func click_sound():
	click.play.call_deferred()
