extends Control
@onready var coins_label: Label = $coins_label
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
var coins = 0
var main_menu = preload("res://scenes/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owned_abilites=cheese.owned_abilites
	coin_costs=cheese.coin_costs
	total_abilites=cheese.total_abilites
	coins = cheese.coins
	cheese.coins = coins
	coins_label.text = "Coins: "+str(coins)
	coins = 20
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	cheese.coins = coins
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	cheese.owned_abilites=owned_abilites
	cheese.coin_costs=coin_costs
	cheese.total_abilites=total_abilites
	cheese.coins = coins
	cheese.equipped_ability = equipped_ability


func _on_dash_pressed() -> void:
	manage_ability(0)


func _on_spike_ball_pressed() -> void:
	manage_ability(1)


func _on_ability_3_pressed() -> void:
	manage_ability(2)


func _on_fireball_pressed() -> void:
	manage_ability(3)
func manage_ability(index):
	if owned_abilites.has(total_abilites[index]):
		change_ability(index)
	else:
		buy_ability(index)
func change_ability(index):
	equipped_ability = total_abilites[index]
	print(equipped_ability)
func buy_ability(index):
	if coin_costs[index]<=coins:
		coins-=coin_costs[index]
		owned_abilites.append(total_abilites[index])
		update_UI(coins)
		print(owned_abilites,"  ",coins)
		change_ability(index)
	else:
		print("you dont have enough money for this purchase")
func update_UI(Coin):
	coins_label.text = "Coins: "+str(Coin)
