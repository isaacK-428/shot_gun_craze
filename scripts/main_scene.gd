extends Node2D

var enemy_N = 2
var stop_WTF = false
var wave_n = 1
var d = null
var this_wave_enemies = null
var waiting_for_perk = false
var perk_scene = preload("res://scenes/perk_scene.tscn")
var I1 = null
var I2 = null
var I3= null
@onready var enemy_spawn_container: Node = $enemy_spawn_container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cheese.start_level()
	randomize()
	d = cheese.difficulty
	await get_tree().create_timer(2.0).timeout
	wave(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if Input.is_action_just_pressed("restart"):
		#get_tree().reload_current_scene()
	if get_tree().get_nodes_in_group("enemy").is_empty()&&waiting_for_perk == false:
		waiting_for_perk == true
		#await get_tree().create_timer(2.0).timeout
		#wave(wave_n)
		#$player.change_perks = true
		WTF()
		#for enemy in get_tree().get_nodes_in_group("enemy"):
			#enemy.speed*=1.5
		
func wave(wave_number):
	#await get_tree().create_timer(0.5).timeout
	$player/Camera2D/HUD.new_wave(wave_number)
	wave_n+=1
	var number = enemy_N
	cheese.total_alive_enemies = enemy_N
	#await get_tree().create_timer(2.0).timeout
	for i in enemy_N:
		var spawner = enemy_spawn_container.get_children().pick_random()
		spawner.spawn_enemy()
		await get_tree().create_timer(0.2).timeout
	var next_amount = number * d * 1.5
	enemy_N = next_amount
	this_wave_enemies=next_amount
		
	#else:
		#for i in enemy_N:
			#var spawner = enemy_spawn_container.get_children().pick_random()
			#spawner.spawn_enemy()
func WTF():
	if wave_n!=1 && stop_WTF == false:
		stop_WTF = true
		var deletes = get_tree().get_nodes_in_group("bullet")
		for i in deletes:
			i.queue_free()
	else:
		pass
		wave(wave_n)
		#wave(wave_n)
	#wave(wave_n)










func _on_button_pressed() -> void:
	hide_UI()


func _on_button_2_pressed() -> void:
	hide_UI()


func _on_button_3_pressed() -> void:
	hide_UI()
func hide_UI():
	for i in get_tree().get_nodes_in_group("perk"):
		i.queue_free()
	stop_WTF = false
	cheese.choose_perks = false
	wave(wave_n)
	#$player/perks.hide()
	$player/perks/Panel.hide()
	$player/perks/Button.hide()
	$player/perks/Button2.hide()
	$player/perks/Button3.hide()
	
	waiting_for_perk == false
