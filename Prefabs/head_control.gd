extends MeshInstance3D

@onready var vision := $Vision
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(vision)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
