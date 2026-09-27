extends Camera3D
class_name PlayerView

#Focus Variables
@onready var focus_loc: Vector3
@export var player: PlayerCharacter
@onready var enemies
#Determines what the camera focuses on
enum Cam_Focus {ENTITIES, FREE}
@export var cam_foc := Cam_Focus.ENTITIES
@export var def_cam_offset := 1.0

#Position Variables
#Determines camera's position preference
enum Cam_Pos {BEHIND = 1, FIXEDPOINT = 2}
@export var cam_pos := Cam_Pos.BEHIND
var spring_arm: SpringArm3D
var fixed_point: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player)
	spring_arm = player.spring_arm
	call_deferred("set_cam_parent_point")#allows objects to actually be ready

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match cam_foc:
		Cam_Focus.ENTITIES:
			focus_on_entities()
		Cam_Focus.FREE:
			focus_players_forward()

#Details how camera focuses on a particular point
#This point is provided by other functions
func cam_focus(new_loc: Vector3):
	focus_loc = lerp(focus_loc, new_loc,.3)
	look_at(focus_loc)

#Camera will look at the player and any other entities being tracked
func focus_on_entities():
	cam_focus(player.position+(player.basis.z*def_cam_offset))

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

func set_cam_parent_point(point: Node3D = null):
	#Set fixed point to spring arm if null
	if point == null:
		reparent(spring_arm)
		return
	fixed_point = point
	reparent(fixed_point)
	position = Vector3.ZERO
