extends TextureRect

@export var scaleFactor = 5.25
var _minScale = 0.001
var _maxScale = 5

# Called when the node enters the scene tree for the first time.
func _ready():
    _scaleRing(_minScale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    _scaleRing(scale.x + (scale.x * scaleFactor * delta))
    if scale.x >= _maxScale:
        _scaleRing(_minScale)

func _scaleRing(newSize):
    scale.x = newSize
    scale.y = newSize
