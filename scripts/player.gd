extends CharacterBody2D

var coins = 0
var last_coins
var can_fireball = true
var ability_ready = true
var equipped_ability = "dash"
var total_abilites = [
	"dash",
	"spike ball",
	"freeze",
	"fireball"
]
@export var speed = 500
@onready var gun: Marker2D = $gun
@onready var shoot_cooldown: Timer = $shoot_cooldown
@onready var hud: Control = $Camera2D/HUD
@onready var frost_ability_timer: Timer = $frost_ability_timer
@onready var fireball_timer: Timer = $fireball_timer
@onready var shoot_sound: AudioStreamPlayer = $shoot
@onready var melee_swing_sound: AudioStreamPlayer = $melee_swing
@onready var power_up_heal_sound: AudioStreamPlayer = $power_up_heal
@onready var power_up_strength_sound: AudioStreamPlayer = $power_up_strength
@onready var move_sound: AudioStreamPlayer = $move


var change_perks = false
var dash_visual = preload("res://scenes/visual affects/dash_visuals.tscn")
var dash = false
var can_frost = true
var actual_melee_cooldown = true
var invincibilty_frame = false
var can_shoot = true
var dir = Vector2.ZERO
var damage = 1
var credits = 0
var can_melee = true
var can_dash = true
var recoil_amount = Vector2.ZERO
var camera_shake_amount = 5
@export var health = 20
var bullet = preload("res://scenes/bullet.tscn")
var shot_gun_lines = preload("res://scenes/visual affects/shotgun_visuals.tscn")
var shot_gun_particles_1 = preload("res://scenes/shot_gun_particles_hit.tscn")
var fireball = preload("res://scenes/fireball.tscn")
@export var weapon_equiped: String = "pistol"
func _ready() -> void:
	equipped_ability = cheese.equipped_ability
	print(equipped_ability)
	randomize()
	hud.change_health(health)
	gun_changed(weapon_equiped)
	if !equipped_ability == total_abilites[1]: #spike ball
		$Marker2D2.queue_free()
func _physics_process(delta: float) -> void:
	print(ability_ready)
	abilites(delta)
	melee_attack(delta)
	if last_coins!=coins:
		$Camera2D/HUD.change_coins(coins)
		cheese.coins+=1

	$Camera2D.rotation = move_toward($Camera2D.rotation, 0, 5 * delta)
	hud.change_credits(cheese.credits)
	cheese.player_pos = global_position
	move(delta)
	if cheese.choose_perks==false:
		shoot(delta)
	last_coins = coins
func move(delta):
	if can_dash==true:
		if Input.is_action_just_pressed("dash") &&  equipped_ability == total_abilites[0]:
			can_dash = false
			$dash.start()
			$dash_cool_down.start()
			speed = 1600
	if speed!=1600:
		if cheese.choose_perks==false:
			dir = Vector2.ZERO
			if Input.is_action_pressed("go_left"):
				dir.x -=1
			if Input.is_action_pressed("go_right"):
				dir.x +=1
			if Input.is_action_pressed("go_up"):
				dir.y -=1
			if Input.is_action_pressed("go_down"):
				dir.y +=1
	else:
		var D_V_I = dash_visual.instantiate()
		D_V_I.global_position = global_position
		$bullet_container.add_child(D_V_I)
	if dir!=Vector2.ZERO:
		change_sprite(dir)
	if cheese.choose_perks==true:
		dir = Vector2.ZERO
		recoil_amount = Vector2(0,0)		
	velocity=Vector2.ZERO
	velocity+=dir*speed
	velocity+=recoil_amount
	recoil_amount = recoil_amount.move_toward(Vector2.ZERO, 1500 * delta)
	move_and_slide()
func shoot(delta):
	if get_global_mouse_position().x>global_position.x:
		$gun/Node2D.scale.y=1
	else:
		$gun/Node2D.scale.y=-1
	gun.look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot")&&can_shoot==true:
		can_shoot=false
		shoot_cooldown.start()
		if weapon_equiped!="shot gun":
			var B_I = bullet.instantiate()
			B_I.global_position = global_position
			B_I.direction = Vector2.RIGHT.rotated(gun.rotation)
			B_I.direction = B_I.direction.normalized()
			B_I.global_rotation = gun.rotation
			B_I.jump(5,delta)
			B_I.bullet_damage=damage
			$bullet_container.add_child(B_I)
		else:
			$gun/GPUParticles2D.emitting = true
			$gun/GPUParticles2D.restart()
			$Camera2D.rotation_degrees+=(randi_range(-camera_shake_amount,camera_shake_amount))
			$camera_shake_2.start()
			var rays = get_tree().get_nodes_in_group("shotgun_ray")
			var S_I = shot_gun_lines.instantiate()		
			$bullet_container.add_child(S_I)
			S_I.position=global_position
			S_I.rotation = gun.rotation
			#recoil_amount = Vector2.RIGHT.rotated(-gun.rotation*200)
			recoil_amount = Vector2.RIGHT.rotated(gun.rotation + PI) * 600
			for ray in rays:
				if ray.is_colliding():
					var collider = ray.get_collider()
					var collision_point = ray.get_collision_point()
					if collider!=null:
						if collider.has_method("take_damage"):
							collider.take_damage(damage)
							var S_G_I = shot_gun_particles_1.instantiate()
							$bullet_container.add_child(S_G_I)
							S_G_I.global_position=collision_point
							S_G_I.emitting = true
func _on_enemy_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.near_player=true


func _on_enemy_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.near_player=false


func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
func take_damage(amount):
	if invincibilty_frame==false:
		$invinsibilty_frame.start()
		invincibilty_frame=true
		health-=amount
		hud.change_health(health)
		if health<=0:
			self.die()
func die():
	set_physics_process(false)
	await get_tree().create_timer(2.0).timeout
	#var object = get_tree().get_nodes_in_group("delete")
	#for i in object:
		#i.queue_free()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
func gun_changed(gun: String):
	if gun == "pistol":
		damage = 1
		$shoot_cooldown.wait_time = 0.3
	if gun == "smg":
		damage = 0.1
		$shoot_cooldown.wait_time = 0.03
	if gun == "shot gun":
		damage = 2
		$shoot_cooldown.wait_time = 0.3
	if gun == "sniper":
		damage = 10
		$shoot_cooldown.wait_time = 4
	if gun == "machine_gun":
		damage = 0.5
		#$shoot_cooldown.wait_time = 0.2
		$shoot_cooldown.wait_time = 0.1
	if gun == "pistol":
		$gun/Node2D/pistol.show()
		$gun/Node2D/machine_gun.hide()
	if gun == "machine_gun":
		$gun/Node2D/pistol.hide()
		$gun/Node2D/machine_gun.show()
	


func _on_dash_timeout() -> void:
	dash=false
	speed = 500
	ability_ready = false
	hud.change_ready(ability_ready)
func _on_dash_cool_down_timeout() -> void:
	if equipped_ability == total_abilites[0]:
		can_dash = true
		ability_ready = true
		hud.change_ready(ability_ready)
func _on_camera_shake_2_timeout() -> void:
	$Camera2D.rotation_degrees+=(randi_range(-(camera_shake_amount/2),camera_shake_amount/2))


func _on_dash_visuals_timeout() -> void:
	pass # Replace with function body.


func get_coin(number):
	coins+=1
func get_power_up(type: int):
	$power_up.stop()
	$power_up.start(5.0)
	if type == 1:
		take_damage(randi_range(1,2)*-1)
	if type == 2:
		damage = 5


func _on_power_up_timeout() -> void:
	damage = 1
	print("timeout")
func change_sprite(D: Vector2) -> void:
	if D == Vector2.ZERO:
		return # Keep current sprite if not moving
		
	# Round to nearest grid direction (-1, 0, or 1)
	var x = roundi(D.x)
	var y = roundi(D.y)
	match [x, y]:
		[0, -1]:
			$Node2D.rotation_degrees = 270
		[0, 1]:
			$Node2D.rotation_degrees = 90
		[-1, 0]:
			$Node2D.rotation_degrees = 180
		[1, 0]:
			$Node2D.rotation_degrees = 0
		[-1, -1]:
			$Node2D.rotation_degrees = 225
		[1, -1]:
			$Node2D.rotation_degrees = 315
		[-1, 1]:
			$Node2D.rotation_degrees = 135
		[1, 1]:
			$Node2D.rotation_degrees = 45
	


func _on_water_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("water"):
		die()


func _on_invinsibilty_frame_timeout() -> void:
	invincibilty_frame=false


func _on_melee_cooldown_timeout() -> void:
	can_melee = true
	$Marker2D.hide()
	$test.start()
	
func melee_attack(delta):
	if can_melee == true:
		if Input.is_action_just_pressed("melee_attack")&&actual_melee_cooldown==true:
			$actual_melee_cooldown2.start()
			actual_melee_cooldown = false
			can_melee=false
			hud.change_melee_ready(can_melee)
			$melee_cooldown.start()
			$Marker2D.show()
			$Marker2D/Area2D/CollisionShape2D.disabled = false
	else:
		$Marker2D.rotate(30*delta)
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if $melee_cooldown.time_left>0.0:
		body.take_damage(damage*2.5)


func _on_test_timeout() -> void:
	$Marker2D/Area2D/CollisionShape2D.disabled = true


func _on_actual_melee_cooldown_2_timeout() -> void:
	actual_melee_cooldown = true
	hud.change_melee_ready(can_melee)
func abilites(delta):
	if equipped_ability == total_abilites[1]: #spike ball
		$Marker2D2.rotate(delta*2)
	if equipped_ability == total_abilites[2]: #frost
		if Input.is_action_just_pressed("dash"):
			ability_ready = false
			hud.change_ready(ability_ready)
			if can_frost == true:
				can_frost = false
				frost_ability_timer.start()
				for i in get_tree().get_nodes_in_group("enemy"):
					i.frost_self(randf_range(2,5))
	if equipped_ability == total_abilites[3]:
		if can_fireball == true&&Input.is_action_just_pressed("dash"):
			ability_ready = false
			hud.change_ready(ability_ready)
			can_fireball = false
			fireball_timer.start()
			var fireball_instance = fireball.instantiate() 
			fireball_instance.direction = Vector2.RIGHT.rotated(gun.rotation)
			fireball_instance.global_position=global_position
			$bullet_container.add_child(fireball_instance)
			



func _on_spike_ball_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		var S_G_I = shot_gun_particles_1.instantiate()
		S_G_I.global_position = body.global_position
		$bullet_container.add_child(S_G_I)
		S_G_I.emitting = true
		


func _on_frost_ability_timer_timeout() -> void:
	can_frost=true
	ability_ready = true
	hud.change_ready(ability_ready)


func _on_fireball_timer_timeout() -> void:
	can_fireball = true
	ability_ready = true
	hud.change_ready(ability_ready)
