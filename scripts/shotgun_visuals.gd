extends Node2D

@onready var line1: Line2D = $Line2D2
@onready var line2: Line2D = $Line2D3
@onready var line3: Line2D = $Line2D4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_away(PI)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
func fade_away(duration: float = 1.0):
	var tween = create_tween()
	
	# Play all subsequent property tweaks at the same time
	tween.set_parallel(true)
	
	tween.tween_property(line1, "modulate:a", 0.0, duration)
	tween.tween_property(line2, "modulate:a", 0.0, duration*1.3)
	tween.tween_property(line3, "modulate:a", 0.0, duration)
