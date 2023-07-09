extends Sprite2D


const APATH = "res://game components/doorinv.tscn"
var on = preload("res://LevelAssets/ForcefieldRectOn.svg")
var off = preload("res://LevelAssets/ForcefieldRectOff.svg")


func switch(state:bool):
    $AnimatableBody2D.visible = not(state)
    if state:
        texture = off
    else:
        texture = on
