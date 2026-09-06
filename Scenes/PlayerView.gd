extends Camera3D
@onready var player := $"../PlayerCharacter" #Assumes root is world

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_only_follow()
	pass

func player_only_follow():
	look_at(player.position)
