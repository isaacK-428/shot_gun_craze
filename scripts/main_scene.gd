extends Node2D
@onready var player: CharacterBody2D = $player

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
	
	randomize()
	d = cheese.difficulty
	await get_tree().create_timer(2.0).timeout
	wave(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(wave_n)
	
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
	print(d)
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
		cheese.choose_perks = true
		$player/perks.show()
		$player/perks/Panel.show()
		$player/perks/Button.show()
		$player/perks/Button2.show()
		$player/perks/Button3.show()
		var instance_1 = perk_scene.instantiate()
		var instance_2 = perk_scene.instantiate()
		var instance_3 = perk_scene.instantiate()
		instance_1.global_position =$player/Marker2D2 .global_position
		instance_2.global_position = $player/Marker2D3 .global_position
		instance_3.global_position =$player/Marker2D4 .global_position
		add_child(instance_1)
		add_child(instance_2)
		add_child(instance_3)
		I1 = instance_1
		I2 = instance_2
		I3 = instance_3
		var deletes = get_tree().get_nodes_in_group("bullet")
		for i in deletes:
			i.queue_free()
	else:
		pass
		#wave(wave_n)
	#wave(wave_n)










func _on_button_pressed() -> void:
	apply_perk(I1)
	hide_UI()


func _on_button_2_pressed() -> void:
	apply_perk(I2)
	hide_UI()


func _on_button_3_pressed() -> void:
	apply_perk(I3)
	hide_UI()
func hide_UI():
	#$perk_scene.queue_free()
	#$perk_scene2.queue_free()
	#$perk_scene3.queue_free()
	I1.delete_node=true
	I2.delete_node=true
	I3.delete_node=true
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
func apply_perk(instance):
	player.speed*=instance.speed_multiplier
	player.armour_division = instance.armour_division
