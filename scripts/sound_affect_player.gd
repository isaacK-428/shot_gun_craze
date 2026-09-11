extends Node2D
@onready var hit: AudioStreamPlayer = $hit
@onready var death: AudioStreamPlayer = $death

var sound: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match sound:
		1:
			hit.play()
		2:
			death.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
