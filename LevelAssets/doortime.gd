extends Sprite2D


const APATH = "res://game components/doortime.tscn"


var off = preload("res://LevelAssets/TimerFieldFrontOff.svg")
var on = preload("res://LevelAssets/TimerFieldFrontOn.svg")

var instate:bool = true

var time = 0.0


func _process(delta):
    time += delta
    
    $Control/Panel.position = Vector2(lerpf(-233, 233, (time / 2) / $"/root/Node2D/Node2D/RigidBody2D2".cycle), 0)
    
    if instate:
        if time >= $"/root/Node2D/Node2D/RigidBody2D2".cycle:
            instate = false
            $Sprite2D.texture = on
            $"/root/Node2D/Node2D/RigidBody2D2".doorstate = instate
            for i in get_tree().get_nodes_in_group("doorswitchable"):
                i.switch(instate)
    else:
        if time >= $"/root/Node2D/Node2D/RigidBody2D2".cycle * 2:
            instate = true
            time = 0
            $Sprite2D.texture = off
            $"/root/Node2D/Node2D/RigidBody2D2".doorstate = instate
            for i in get_tree().get_nodes_in_group("doorswitchable"):
                i.switch(instate)
        

func switch(state):
    if state:
        texture = on
    else:
        texture = off
