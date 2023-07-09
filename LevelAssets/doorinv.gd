extends Sprite2D


const APATH = "res://game components/doorinv.tscn"
var on = preload("res://LevelAssets/ForcefieldRectOn.svg")
var off = preload("res://LevelAssets/ForcefieldRectOff.svg")


func switch(state:bool):
    if state:
        $AnimatableBody2D.process_mode = Node.PROCESS_MODE_DISABLED
        texture = off
    else:
        $AnimatableBody2D.process_mode = Node.PROCESS_MODE_INHERIT
        texture = on
