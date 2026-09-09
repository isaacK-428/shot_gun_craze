extends Node
var is_dead = false
var can_combo=false
var combo_amount = 0
var player_pos = null
var difficulty = 1
var total_alive_enemies = null
var credits = 0
var delta2 = 1
var choose_perks = false
var coins = 0
var equipped_ability = "dash"
var owned_abilites = [
	"dash"
]
var total_abilites = [
	"dash",
	"spike ball",
	"freeze",
	"fireball"
]
var coin_costs = [
	0,
	7,
	10,
	20
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_dead=false
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta2=delta
func change_credits(amount):
	if can_combo:
		combo_amount+=1
	else:
		combo_amount=1
	credits+=amount*(round(combo_amount/1.5))
	can_combo=true
	$Timer.start()


func _on_timer_timeout() -> void:
	can_combo=false
	combo_amount = 0
func start_level():
	pass
func start():
	is_dead = false
	can_combo=false
	combo_amount = 0
	player_pos = null
	difficulty = 1
	total_alive_enemies = null
	credits = 0
	delta2 = 1
	choose_perks = false
	coins = 0
