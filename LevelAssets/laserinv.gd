extends Sprite2D


const APATH = "res://game components/laser.tscn"
var on = preload("res://LevelAssets/LaserOn.svg")
var off = preload("res://LevelAssets/LaserOff.svg")
var part = preload("res://LevelAssets/deathpart.tscn")


func switch(state:bool):
    if state:
        $AnimatableBody2D.process_mode = Node.PROCESS_MODE_DISABLED
        texture = off
    else:
        $AnimatableBody2D.process_mode = Node.PROCESS_MODE_INHERIT
        texture = on


func _on_area_2d_body_entered(body):
    if body is Player:
        $"/root/Node2D/Node2D/RigidBody2D2".lost()
        var h = part.instantiate()
        h.position = body.position
        $"../../".add_child(h)
        body.queue_free()
