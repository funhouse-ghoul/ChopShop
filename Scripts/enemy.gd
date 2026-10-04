extends CharacterBody3D
class_name EnemyBody

@onready var nav_agent = $NavigationAgent3D
@export var speed = 1.0
@export var player : PlayerCharacter
var in_range:= .5

func _ready():
	assert(player)

func _physics_process(delta):
	
	update_target_location(player.global_position)
	if position.distance_to(player.global_position) > in_range:
		var currLoc = global_transform.origin
		print(currLoc)
		var nextLoc = nav_agent.get_next_path_position()
		#print(nextLoc)
		var newVel = (nextLoc - currLoc).normalized() * speed
		velocity = newVel
		print(velocity)
		move_and_slide()

func update_target_location(target_pos):
	nav_agent.target_position = target_pos
