extends RigidBody2D


var reset_state := false
var lname := ""
var cycle := 0.0
var doorstate := true
var laserstate := true

var downtrack := true


func rebuild():
    get_tree().reload_current_scene()


# Called when the node enters the scene tree for the first time.
func _ready():
    build(Glob.last)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position = Vector2.ZERO
    
    if ProjectSettings.get_setting("Gameplay/InvertRotation"):
        apply_torque(Input.get_axis("game_move_right", "game_move_left") * delta * 1)
    else:
        apply_torque(Input.get_axis("game_move_left", "game_move_right") * delta * 1)
    $"../content".rotation = rotation
    
    if Input.get_action_raw_strength("game_down") > 0.9:
        if downtrack:
            down()
            downtrack = false
    else:
        downtrack = true

        
func build(level:String) -> void:
    Glob.last = level
    reset_state = true
    doorstate = true
    laserstate = true
    
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
    $Timer.start()


func won():
    if $Timer.is_stopped():
        if $"../players".get_children().size() <= 1:
            Glob.currentLevel += 1
            match Glob.currentLevel:
                2:
                    Glob.last = "res://levels/second.json"
                3:
                    Glob.last = "res://levels/firstDual.json"
                4:
                    Glob.last = "res://levels/firstHazard.json"
                5:
                    Glob.last = "res://levels/firstField.json"
                _:
                    var levelArray = Array(DirAccess.get_files_at("res://levels/"))
                    levelArray.shuffle()
                    while "res://levels/" + levelArray[0] == Glob.last:
                        levelArray.shuffle()
                    Glob.last = "res://levels/" + levelArray[0]
            get_tree().reload_current_scene()
                    
    

func down():
    $AnimationPlayer.stop()
    $AnimationPlayer.play("down")
    for i in $"../players".get_children():
        i.apply_impulse(Vector2.DOWN * 1000)
