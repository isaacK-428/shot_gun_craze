extends Node2D

var enemy_N = 2
var wave_n = 1
var d = null
var this_wave_enemies = null
@onready var enemy_spawn_container: Node = $enemy_spawn_container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	d = cheese.difficulty
	await get_tree().create_timer(2.0).timeout
	wave(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if Input.is_action_just_pressed("restart"):
		#get_tree().reload_current_scene()
	if get_tree().get_nodes_in_group("enemy").is_empty():
		#await get_tree().create_timer(2.0).timeout
		#wave(wave_n)
		WTF()
		for enemy in get_tree().get_nodes_in_group("enemy"):
			enemy.speed*=1.5
		
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
	wave(wave_n)
