extends MeshInstance3D

@export var y_rot_spd := 1.0  
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("io+r"):
		process_rotation(delta, -y_rot_spd)
	elif Input.is_action_pressed("io-r"):
		process_rotation(delta, y_rot_spd)
	pass

func process_rotation(delta, mag = y_rot_spd):
	transform.basis = transform.basis.rotated(transform.basis.y, mag*delta)
	
