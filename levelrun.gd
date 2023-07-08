extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position = Vector2.ZERO
    
    if ProjectSettings.get_setting("Gameplay/InvertRotation"):
        apply_torque(Input.get_axis("game_move_right", "game_move_left") * delta * 8)
    else:
        apply_torque(Input.get_axis("game_move_left", "game_move_right") * delta * 8)
