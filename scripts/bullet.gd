extends Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var light: PointLight2D = $PointLight2D
@onready var visual: Sprite2D = $Sprite2D
@onready var gpu_part: GPUParticles2D = $GPUParticles2D

var speed = 50
var direction = null
var bullet_damage = 0.3
var active = true
var asleep = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		if direction:
			position+=direction*speed*delta
	else:
		if !$Timer.time_left > 0.0:
			$Timer.start()
			$Sprite2D.hide()
func jump(amount,delta):
	for i in amount:
		position+=direction*speed*delta


func _on_body_entered(body: Node2D) -> void:
	if active:
		if has_overlapping_bodies():
			for i in get_overlapping_bodies():
				if body.is_in_group("normal_map"):
					active = false
					light.enabled = false
					sprite.hide()
				if body.has_method("take_damage"):
					if body.has_method("start_bullet_visual"):
						body.on_enemy = true
						body.start_bullet_visual()
					body.take_damage(bullet_damage)
					active = false
					sprite.hide()
					light.enabled = false
					
					return


func _on_timer_timeout() -> void:
	delete_bullet()
func delete_bullet():
	despawn()
func take_damage():
	despawn()
func despawn():
	gpu_part.emitting = false
	set_process(false)
	self.add_to_group("asleep_bullet")
	sprite.hide()
	active = false
	sprite.hide()
	light.enabled = false
func spawn():
	gpu_part.emitting = true
	light.enabled = true
	active = true
	set_process(true)
	if self.is_in_group("asleep_bullet"):
		self.remove_from_group("asleep_bullet")
	sprite.show()
	
