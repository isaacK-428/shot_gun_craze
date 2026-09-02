extends Panel
var delete_node: bool = false
@onready var sprite: Sprite2D = $Sprite2D
@onready var perk_label: Label = $Label

var speed_multiplier = 1
var health_addittion = 0
var gun_size_multiplier = 1
var fire_rate_multiplier = 1
var melee_attack_cooldown_multipier = 1
var armour_division = 1
var perks = [
	"health",
	"armour",
	"damage",
	"fire rate",
	"melee attacks",
	"bigger gun", #more range
	"speed",
]
var perk_type = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	perk_type = perks.pick_random()
	perk_label.text = str(perk_type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if delete_node == true:
		queue_free()
