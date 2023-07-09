extends Node2D


const APATH = "res://game components/Goal.tscn"
var part = preload("res://LevelAssets/deathpart.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_area_2d_body_entered(body):
    if body is Player:
        $"/root/Node2D/Node2D/RigidBody2D2".won()
        var h = part.instantiate()
        h.position = body.position
        $"../../".add_child(h)
        body.queue_free()
