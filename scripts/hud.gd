extends Control

var can_wave = false
@onready var off: Sprite2D = $off
@onready var on: Sprite2D = $on
@onready var on_melee: Sprite2D = $on_melee
@onready var off_melee: Sprite2D = $off_melee


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_wave(1)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func change_health(health):
	$health.text = "Health: "+ str(health)
func change_credits(credits):
	$score.text = "score: "+ str(credits)
func new_wave(Wave):
	if can_wave == true && Wave!=0:
		#if Wave!=1:
			#$Label.text = "Wave " + str(Wave-1)
		#if Wave!=1:
		if Wave!=1:
			$Label.text = "Wave " + str(Wave-1)
			$Label.show()
			var tween = create_tween()
			tween.set_parallel(true)
			$Label.modulate.a = 1.0
			tween.tween_property($Label, "modulate:a", 0.0, 1.0)
		else:
			$Label.text = "Wave " + str(Wave)
			$Label.show()
			var tween = create_tween()
			tween.set_parallel(true)
			$Label.modulate.a = 1.0
			tween.tween_property($Label, "modulate:a", 0.0, 1.0)


func _on_timer_timeout() -> void:
	can_wave = true
func change_coins(amount):
	$coins.text = "Coins:" + str(amount)
func change_ready(ready):
	if ready == true:
		on.show()
		off.hide()
	else:
		on.hide()
		off.show()
func change_melee_ready(ready):
	on_melee.hide()
	off_melee.hide()
	if ready == true:
		on_melee.show()
	else:
		off_melee.show()
