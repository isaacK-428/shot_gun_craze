extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Combo! "+str(cheese.combo_amount)
	fade_away(1.3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func fade_away(duration: float = 1.0): 

	var tween = create_tween() 
	# Play all subsequent property tweaks at the same time 
	tween.set_parallel(true) 
	tween.tween_property($".", "modulate:a", 0.0, duration) 



func _on_timer_timeout() -> void:
	queue_free()
