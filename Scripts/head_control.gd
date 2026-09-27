extends MeshInstance3D

@export var camera : PlayerView
@onready var vision := $Vision
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(camera)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
