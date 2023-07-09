extends Sprite2D


const APATH = "res://game components/button.tscn"


var off = preload("res://LevelAssets/SwitchFieldOff.svg")
var on = preload("res://LevelAssets/SwitchFieldOn.svg")


func _on_area_2d_body_entered(body):
    if body is Player:
        var state = not($"/root/Node2D/Node2D/RigidBody2D2".doorstate)
        $"/root/Node2D/Node2D/RigidBody2D2".doorstate = state
        for i in get_tree().get_nodes_in_group("doorswitchable"):
            i.switch(state)

func switch(state):
    if state:
        texture = on
    else:
        texture = off
