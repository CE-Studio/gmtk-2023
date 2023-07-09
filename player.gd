extends RigidBody2D
class_name Player


const APATH = "res://game components/player.tscn"


@onready var sprite:Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    sprite.rotation = -rotation + (angular_velocity / 50)
