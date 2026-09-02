extends Area2D
var spawn_range = 100
var enemy = preload("res://scenes/enemy.tscn")
@onready var node: Node = $Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_enemy():
	var E_I = enemy.instantiate()
	var boss_chance = randi_range(1,100)
	E_I.global_position.x=global_position.x+randi_range(-spawn_range,spawn_range)
	E_I.global_position.y=global_position.y+randi_range(-spawn_range,spawn_range)
	E_I.Root = $"../.."
	var type = randi_range(1,6)
	match type:
		1:
			E_I.enemy_type = "normal"
		2:
			E_I.enemy_type = "fast"
		3:
			E_I.enemy_type = "tank"
		4:
			E_I.enemy_type = "demon"
		5:
			E_I.enemy_type = "ADHD"
		6:
			E_I.enemy_type = "shooter"
		7:
			E_I.enemy_type = "bomber"
	if boss_chance == 50:
		E_I.enemy_type = "BOSS"
	node.add_child(E_I)
	
