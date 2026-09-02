extends Control
@onready var coins_label: Label = $coins_label
var equipped_ability = "dash"
var owned_abilites = [
	"dash"
]
var total_abilites = [
	"dash",
	"spike ball",
	"ability 3"
]
var coin_costs = [
	0,
	7,
	10
]
var coins = 0
var main_menu = preload("res://scenes/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins = cheese.coins
	cheese.coins = coins
	coins = 20
	coins_label.text = "Coins: "+str(coins)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_dash_pressed() -> void:
	manage_ability(0)


func _on_spike_ball_pressed() -> void:
	manage_ability(1)


func _on_ability_3_pressed() -> void:
	manage_ability(2)
func manage_ability(index):
	if owned_abilites.has(total_abilites[index]):
		change_ability(index)
	else:
		buy_ability(index)
func change_ability(index):
	equipped_ability = total_abilites[index]
func buy_ability(index):
	if coin_costs[index]<=coins:
		coins-=coin_costs[index]
		owned_abilites.append(total_abilites[index])
		update_UI(coins)
		print(owned_abilites,"  ",coins)
	else:
		print("you dont have enough money for this purchase")
func update_UI(Coin):
	coins_label.text = "Coins: "+str(Coin)
