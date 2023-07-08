extends Control
@export var rotSpeed = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = randf() * 60


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += delta * rotSpeed
