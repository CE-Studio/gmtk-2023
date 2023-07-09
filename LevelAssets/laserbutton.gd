extends Sprite2D


const APATH = "res://game components/laserbutton.tscn"


var off = preload("res://LevelAssets/SwitchLaserOff.svg")
var on = preload("res://LevelAssets/SwitchLaserOn.svg")


func _on_area_2d_body_entered(body):
    if body is Player:
        var state = not($"/root/Node2D/Node2D/RigidBody2D2".laserstate)
        $"/root/Node2D/Node2D/RigidBody2D2".laserstate = state
        for i in get_tree().get_nodes_in_group("laserswitchable"):
            i.switch(state)

func switch(state):
    if state:
        texture = on
    else:
        texture = off
