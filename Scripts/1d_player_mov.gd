extends PathFollow3D

@export var prog_spd := 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("io+x"):
		progress+=prog_spd*delta
	elif Input.is_action_pressed("io-x"):
		progress-=prog_spd*delta
	pass
