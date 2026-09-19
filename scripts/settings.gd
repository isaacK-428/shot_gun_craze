extends Control
var can_change = false
var main_menu = preload("res://scenes/UI/main_menu.tscn")
var bus_Master= AudioServer.get_bus_index("Master")
var bus_Music= AudioServer.get_bus_index("Music")
var bus_SFX= AudioServer.get_bus_index("SFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_volumes.call_deferred()
	can_change = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
	cheese.MASTER = $master.value
	cheese.SFX = $SFX.value
	cheese.MUSIC = $music.value
	cheese.click_sound()



func _on_master_value_changed(value: float) -> void:
	if can_change == true:
		AudioServer.set_bus_volume_db(bus_Master, linear_to_db(value))


func _on_music_value_changed(value: float) -> void:
	if can_change == true:
		AudioServer.set_bus_volume_db(bus_Music, linear_to_db(value))


func _on_sfx_value_changed(value: float) -> void:
	if can_change == true:
		AudioServer.set_bus_volume_db(bus_SFX, linear_to_db(value))
func set_volumes():
	can_change = true
	$master.value = cheese.MASTER
	$music.value = cheese.MUSIC
	$SFX.value = cheese.SFX
