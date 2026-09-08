extends CharacterBody2D
var near_player = false
var enemy_target_range= 40
var speed= 60
var health = 3
var credits = 5
var Root = null
var blood = preload("res://scenes/visual affects/blood.tscn")
var coin  = preload("res://scenes/coin.tscn")
var inside = false
var combo = preload("res://scenes/combo.tscn")
var power_up = preload("res://scenes/power_up.tscn")
var bomb = preload("res://scenes/explosive.tscn")
var hit_particles = preload("res://scenes/shot_gun_particles_hit.tscn")
var can_damage = true
var player_guy = null
var target = "interest"
var interest = null
var frosted = false
var recoil_amount = Vector2.ZERO
var bullet = preload("res://scenes/bullet.tscn")
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@export var player = Vector2.RIGHT
@export var enemy_type: String = "normal"
@onready var gun: Marker2D = $Marker2D
@onready var freeze_timer: Timer = $freeze_timer
@onready var container: Node = $bullet_container

#take_damage()
func _ready():
	set_physics_process(false)
	special_enemy_stats()
	interest = get_tree().get_nodes_in_group("interest_point").pick_random().global_position
	health*=2

func _physics_process(delta: float) -> void:
	recoil_amount.move_toward(Vector2.ZERO,2200.0*delta)
	if enemy_type == "shooter" || enemy_type == "bomber":
		gun.look_at(cheese.player_pos)
	#print(inside,"   ",can_damage)
	if inside:
		if can_damage == true:
			if enemy_type!="shooter":
				player_guy.take_damage(1)
				can_damage=false
				$player_damage.start()
	var dir = to_local(agent.get_next_path_position()).normalized()
	if near_player==true && enemy_type == "shooter":
		dir = Vector2.ZERO
	if dir!=Vector2.ZERO:
		velocity = (dir*speed)+recoil_amount
	if frosted==true:
		velocity = Vector2.ZERO
		
	move_and_slide()


func _on_timer_timeout() -> void:
	$Timer.wait_time = randf_range(0.4,0.85)
	#$CollisionShape2D.disabled = false
	#$Sprite2D.show()
	#$Sprite2D2.hide()
	player = cheese.player_pos
	agent.target_position = player
	if !near_player:
		agent.target_position.y+=randf_range(-enemy_target_range,enemy_target_range)
		agent.target_position.x+=randf_range(-enemy_target_range,enemy_target_range)
		var a_range = 60
		#agent.target_position.x+=randf_range(-a_range,a_range)
		#agent.target_position.y+=randf_range(-a_range,a_range)
		if enemy_type == "ADHD":
			if target != "player":
				agent.target_position=interest

func take_damage(amount):
	var hit = hit_particles.instantiate()
	hit.global_position = global_position
	hit.emitting = true
	get_parent().add_child(hit)
	health-=amount
	if health<=0:
		die.call_deferred()
func die():
	loot_drops()
	cheese.total_alive_enemies-=1
	queue_free()
	spawn_blood()
	if credits!=0:
		cheese.change_credits(credits)
		credits = 0
		if cheese.can_combo&&cheese.combo_amount>1:
			var C_I = combo.instantiate()
			get_tree().root.add_child(C_I)
			C_I.position=global_position+Vector2(20,-20)
func _on_player_detect_body_entered(body: Node2D) -> void:
	inside = true
	player_guy = body
	body.on_enemy=true
func _on_player_detect_body_exited(body: Node2D) -> void:
	inside = false
	player_guy = null
	body.on_enemy=false
func _on_player_damage_timeout() -> void:
	can_damage = true
func special_enemy_stats():
	if enemy_type == "normal":
		speed = 60
		health = 3
	if enemy_type == "fast":
		speed = 120
		health = 2
	if enemy_type == "tank":
		speed = 40
		health = 7
	if enemy_type == "demon":
		speed = 160
		health = 1
	if enemy_type == "boss":
		speed = 160
		health = 25
		global_scale = Vector2(2,2)
	if enemy_type == "ADHD":
		speed = 90
		health = 7
		$Area2D.queue_free()
		$Marker2D.queue_free()
		$shoot_timer.queue_free()
		$bullet_container.queue_free()
		return
	if enemy_type == "shooter":
		speed = 20
		health = 2
		return
	if enemy_type == "bomber":
		speed = 70  
		health = 6
		$ADHD_timer.queue_free()
		$Area2D.queue_free()
		$bullet_container.queue_free()
		return
	$ADHD_timer.queue_free()
	$Area2D.queue_free()
	$Marker2D.queue_free()
	$shoot_timer.queue_free()
	$bullet_container.queue_free()


func _on_adhd_timer_timeout() -> void:
	if enemy_type == "ADHD":
		if target == "player":
			interest = get_tree().get_nodes_in_group("interest_point").pick_random().global_position
			target = "interest"
		else:
			target = "player"
	else:
		pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	target = "player"
func change_interest():
	target = "player"


func _on_shoot_timer_timeout() -> void:
	if enemy_type == "shooter":
		var B_I = bullet.instantiate()
		B_I.global_position = global_position
		B_I.direction = Vector2.RIGHT.rotated(gun.rotation)
		B_I.rotation_degrees+=randi_range(-20,20)
		B_I.direction = B_I.direction.normalized()
		B_I.global_rotation = gun.rotation
		B_I.jump(5,cheese.delta2)
		B_I.bullet_damage=1
		Root.add_child(B_I)
		#recoil_amount = Vector2.RIGHT.rotated(gun.rotation + PI) * 7
func spawn_blood():
	for i in 10:
		var blood_instance = blood.instantiate()
		blood_instance.global_position = global_position

		blood_instance.direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		blood_instance.direction = blood_instance.direction.normalized()
		Root.add_child(blood_instance)
func loot_drops():
	var chance = randi_range(0,8)
	if chance==1:
		for i in randi_range(0,3):
			var C_II = coin.instantiate()
			C_II.global_position = global_position+Vector2(randi_range(-20,20),randi_range(-20,20))
			get_parent().add_child(C_II)
	if chance == 2:
		var power_up_instance = power_up.instantiate()
		get_tree().root.add_child(power_up_instance)
		power_up_instance.global_position = global_position


func _on_timer_2_timeout() -> void:
	$CollisionShape2D.disabled = false
	$Sprite2D.show()
	$Sprite2D2.hide()
	$Timer2.queue_free()
	set_physics_process(true)


func _on_water_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("water"):
		die()
func frost_self(length):
	frosted = true
	freeze_timer.start(length)


func _on_freeze_timer_timeout() -> void:
	frosted = false
