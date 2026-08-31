extends Area2D
@export var weapon: String = "machine_gun"
var weapon_copy = weapon
var player_inside = false
var player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_inside == true:
		if Input.is_action_just_pressed("pick_up") && player:
			player.gun_changed(weapon)
			visible()


func _on_body_entered(body: Node2D) -> void:
	player_inside = true
	player = body


func _on_body_exited(body: Node2D) -> void:
	player_inside = false
	player = null
func visible():
	if weapon == "pistol":
		$pistol.show()
		$"machine gun".hide()
	if weapon == "machine_gun":
		$pistol.hide()
		$"machine gun".show()
