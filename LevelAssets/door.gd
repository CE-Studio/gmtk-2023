extends Sprite2D


const APATH = "res://game components/door.tscn"
var on = preload("res://LevelAssets/ForcefieldRectOn.svg")
var off = preload("res://LevelAssets/ForcefieldRectOff.svg")


func switch(state:bool):
    $AnimatableBody2D.visible = state
    if state:
        texture = on
    else:
        texture = off
