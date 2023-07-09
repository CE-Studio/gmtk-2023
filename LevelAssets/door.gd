extends Sprite2D


const APATH = "res://game components/door.tscn"
var on = preload("res://LevelAssets/ForcefieldRectOn.svg")
var off = preload("res://LevelAssets/ForcefieldRectOff.svg")
@onready var particle1 = $CPUParticles2D
@onready var particle2 = $CPUParticles2D2


func switch(state:bool):
    if state:
        $AnimatableBody2D.process_mode = Node.PROCESS_MODE_INHERIT
        texture = on
        particle1.emitting = true
        particle2.emitting = true
    else:
        $AnimatableBody2D.process_mode = Node.PROCESS_MODE_DISABLED
        texture = off
        particle1.emitting = false
        particle2.emitting = false
