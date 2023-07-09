extends RigidBody2D


var lname := ""
var cycle := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
    build("res://levels/testlevel.json")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position = Vector2.ZERO
    
    if ProjectSettings.get_setting("Gameplay/InvertRotation"):
        apply_torque(Input.get_axis("game_move_right", "game_move_left") * delta * 1)
    else:
        apply_torque(Input.get_axis("game_move_left", "game_move_right") * delta * 1)
    $"../content".rotation = rotation
        
        
func build(level:String) -> void:
    rotation = 0
    
    for i in $"../content".get_children():
        i.queue_free()
    for i in $"../players".get_children():
        i.queue_free()
    var f = FileAccess.open(level, FileAccess.READ)
    var t = f.get_as_text()
    f.close()
    var thedata = JSON.parse_string(t)
    lname = thedata["name"]
    cycle = thedata["cycle"]
    var v2r := PackedVector2Array()
    for i in thedata["geom"]:
        v2r.append(Vector2(i[0], i[1]))
    $Sprite2D/Polygon2D.polygon = v2r
    $CollisionPolygon2D.polygon = v2r
    for c in thedata["items"]:
        var h:Node2D = load(c["type"]).instantiate()
        if c["type"] == "res://game components/player.tscn":
            $"../players".add_child(h)
        else:
            $"../content".add_child(h)
        h.position = Vector2(c["pos"][0], c["pos"][1])
        h.rotation = c["rot"]
        

func lost():
    pass
