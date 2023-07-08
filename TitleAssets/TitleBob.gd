extends TextureRect
var elapsed = 0
var speedMod = 1.85
var amplitude = 10
@onready var originY = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta * speedMod
	position.y = originY + sin(elapsed) * amplitude
