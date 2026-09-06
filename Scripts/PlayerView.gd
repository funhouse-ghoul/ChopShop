extends Camera3D
@onready var player := $"../PlayerCharacter" #Assumes root is world
@onready var focus_loc: Vector3

enum Cam_Style {PLAYERFOLLOW, PLAYERFACING, MULTIFOCUS}
@export var cam_sty := Cam_Style.PLAYERFOLLOW

@onready var enemies
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player)
	update_enemies_list()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match cam_sty:
		Cam_Style.PLAYERFOLLOW:
			player_only_follow()
		Cam_Style.PLAYERFACING:
			face_player_forward()
		Cam_Style.MULTIFOCUS:
			multifocus()
	pass

func cam_focus(new_loc: Vector3):
	focus_loc = lerp(focus_loc, new_loc,.3)
	look_at(focus_loc)

func player_only_follow():
	cam_focus(player.position)
	
func face_player_forward():
	cam_focus(position+player.basis.z)
	
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
