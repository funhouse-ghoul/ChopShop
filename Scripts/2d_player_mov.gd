extends CharacterBody3D

@export var y_rot_spd := 1.0  
@export var x_lin_spd := 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Rotation logic
	process_rotation(delta)
	
	#Linear Movement Logic, 1 dimension
	if Input.is_action_pressed("io+x"):
		process_lin_move(delta, x_lin_spd)
	elif Input.is_action_pressed("io-x"):
		process_lin_move(delta, -x_lin_spd)
	
	

func process_rotation(delta):
	if Input.is_action_pressed("io+r"):
		transform.basis = transform.basis.rotated(transform.basis.y, -y_rot_spd*delta)
	elif Input.is_action_pressed("io-r"):
		transform.basis = transform.basis.rotated(transform.basis.y, y_rot_spd*delta)
	

func process_lin_move(delta, mag):
	move_and_slide()
