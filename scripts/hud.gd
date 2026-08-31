extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_wave(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_health(health):
	$health.text = "Health: "+ str(health)
func change_credits(credits):
	$credits.text = "score: "+ str(credits)
func new_wave(Wave):
	$Label.text = "Wave " + str(Wave)
	$Label.show()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Label, "modulate:a", 0.0, 1.0)
