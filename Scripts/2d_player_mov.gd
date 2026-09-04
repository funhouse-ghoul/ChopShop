extends CharacterBody3D

@export var y_rot_spd := 1.0  
@export var lin_spd := 1.0
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

#Applies motion to object in x axis
func get_lin_move_x(): 
	return -basis.x*Input.get_axis("io+x","io-x")

#Applies motion to object in y axis
func get_lin_move_y():
	return -basis.z*Input.get_axis("io+y","io-y")

#Encapsulate representing "Tank Controls"
func lin_1d_and_rot(delta):
	proc_y_rotation(delta)
	update_velocity(get_lin_move_x())

#Encapsulate repr. 2d move on a flat plane
func lin_2d_move() -> void:
	var vec = (get_lin_move_x()+get_lin_move_y())
	update_velocity(vec)

func update_velocity(vec: Vector3)->void:
	velocity = vec.normalized()*lin_spd
