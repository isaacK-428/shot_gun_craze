extends Node2D
@onready var hit: AudioStreamPlayer = $hit
@onready var death: AudioStreamPlayer = $death

var sound: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$hit.pitch_scale = randf_range(0,5)
	match sound:
		
		1:
			hit.play()
			print("hit")
		2:
			$hit.pitch_scale = randf_range(4,7)
			hit.play()
			print("death")
	print("   ")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
