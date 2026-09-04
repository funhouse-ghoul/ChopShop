extends CharacterBody3D

@export var y_rot_spd := 1.0  
@export var x_lin_spd := 1.0
@export var y_lin_spd := 1.0
enum Move_Style {TANK, FLAT2D}
@export var mov_sty := Move_Style.TANK
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#---Movement---
	match mov_sty:
		Move_Style.TANK:
			lin_1d_and_rot(delta)
		Move_Style.FLAT2D:
			lin_2d_move()

	move_and_slide()
	#---End---

#applies y movement around rotation
func proc_y_rotation(delta):
	transform.basis = transform.basis.rotated(
		transform.basis.y,
		Input.get_axis("io+y","io-y")*delta*y_rot_spd)

#Encapsulate representing "Tank Controls"
func lin_1d_and_rot(delta):
	proc_lin_move_x()
	proc_y_rotation(delta)

#Encapsulate repr. 2d move on a flat plane
func lin_2d_move():
	proc_lin_move_x()
	proc_lin_move_y()

#Applies motion to object in x axis
func proc_lin_move_x():
	velocity += basis.x*Input.get_axis("io+x","io-x")*-x_lin_spd

#Applies motion to object in y axis
func proc_lin_move_y():
	velocity += basis.z*Input.get_axis("io+y","io-y")*y_lin_spd
