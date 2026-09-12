extends Camera3D
class_name PlayerView

#Focus Variables
@onready var focus_loc: Vector3
@onready var player := $"../PlayerCharacter" #Assumes root is world
@onready var enemies
enum Cam_Style {PLAYERFOLLOW, PLAYERLOOK3RD, MULTIFOCUS}
@export var cam_sty := Cam_Style.PLAYERFOLLOW

#Position Variables
@onready var spring_arm = $"../PlayerCharacter/PlayerSpringArm"
enum Cam_Pos {BEHIND = 1, FIXEDPOINT = 2}
@export var cam_pos := Cam_Pos.BEHIND
@onready var fixed_point := $"../CamPoint"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player)
	update_enemies_list()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match cam_sty:
		Cam_Style.PLAYERFOLLOW:
			focus_on_player()
		Cam_Style.PLAYERLOOK3RD:
			focus_players_forward()
		Cam_Style.MULTIFOCUS:
			multifocus()

	if Input.is_action_just_pressed("cam_1"):
		switch_cam_position_mode(Cam_Pos.BEHIND)
	if Input.is_action_just_pressed("cam_2"):
		switch_cam_position_mode(Cam_Pos.FIXEDPOINT)

#Details how camera focuses on a particular point
#This point is provided by other functions
func cam_focus(new_loc: Vector3):
	focus_loc = lerp(focus_loc, new_loc,.3)
	look_at(focus_loc)

#Camera exclusively looks at the player's 
func focus_on_player():
	cam_focus(player.position)

#Camera effectively copies the player's forward vector
func focus_players_forward():
	cam_focus(position+player.basis.z)

#Helper functions to get all enemies in the scene
#TODO: Make it only relevant to a particular radius
func update_enemies_list():
	enemies = get_tree().get_nodes_in_group("enemies")

#Relies on enemies list
#Points camera ad middle distance between several focus points and player
func multifocus():
	var rel_en_pos = player.position
	for en in enemies:
		rel_en_pos += en.position
	rel_en_pos = rel_en_pos/(enemies.size()+1)
	cam_focus(rel_en_pos)

#Reparents to the player's spring arm
func arm_follow():
	reparent(spring_arm)

#Primary routing functions to switch between modes
func switch_cam_position_mode(pos_mode: Cam_Pos):
	print(pos_mode)
	match pos_mode:
		Cam_Pos.BEHIND:
			arm_follow()
		Cam_Pos.FIXEDPOINT:
			#set cam to nearest fixed point
			set_nearest_fixed_point(fixed_point)
			#Need some way to keep camera "listening" for more fixed points
			pass

func set_nearest_fixed_point(point: CameraFixedPoint):
	print("setfixedpoint called")
	fixed_point = point
	#changes parent only if in Fixed Point mode for external calls
	if cam_pos == Cam_Pos.FIXEDPOINT:
		reparent(fixed_point)
		position = Vector3.ZERO
