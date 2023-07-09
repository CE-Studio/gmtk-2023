extends Control


@onready var level:Sprite2D = $Node2D/Sprite2D
@onready var levelc:Node2D = $Node2D/Sprite2D/Node2D
@onready var geom:Polygon2D = $Node2D/Sprite2D/Polygon2D
@onready var geomdb:Line2D = $Node2D/Sprite2D/Line2D
var button:PackedScene = preload("res://assetbutton.tscn")
var asset:PackedScene = preload("res://game components/player.tscn")
var assetButtons:Array[AssetButton] = []
var assets:Array[Node2D] = []
var apath:String = "res://game components/player.tscn"
var placing := false


func add_asset(path:String) -> void:
    apath = path
    asset = load(path)


func _ready():
    for i in DirAccess.get_files_at("res://game components/"):
        var h:AssetButton = button.instantiate()
        h.apath = "res://game components/" + i
        assetButtons.append(h)
        $ScrollContainer/PanelContainer/VBoxContainer.add_child(h)
        
    for i in assetButtons:
        i.disabled = true


func _input(event:InputEvent):
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        var lops:Vector2 = level.to_local(event.position)
        if level.get_rect().has_point(lops):
            $ScrollContainer/PanelContainer/VBoxContainer/load.disabled = true
            $ScrollContainer/PanelContainer/VBoxContainer/load.text = "Click New to load"
            if placing:
                var h:Node2D = asset.instantiate()
                $Node2D/Sprite2D/Node2D.add_child(h)
                assets.append(h)
                h.position = lops
                h.process_mode = PROCESS_MODE_DISABLED
            else:
                var poly = geom.polygon
                poly.append(lops)
                geom.polygon = poly
                geomdb.points = poly
    elif event is InputEventMouseMotion:
        $HSeparator.position.y = event.position.y - 2
        $VSeparator.position.x = event.position.x - 2
        $Panel.position = event.position - Vector2(30, 30)
            

func _export_pressed():
    var thedata = {}
    thedata["name"] = $ScrollContainer/PanelContainer/VBoxContainer/LineEdit.text
    thedata["cycle"] = $ScrollContainer/PanelContainer/VBoxContainer/HBoxContainer/SpinBox.value
    thedata["geom"] = []
    for i in geom.polygon:
        thedata["geom"].append([i.x, i.y])
    thedata["items"] = []
    for i in levelc.get_children():
        var c = {}
        c["pos"] = [i.position.x, i.position.y]
        c["rot"] = i.rotation
        c["type"] = i.APATH
        thedata["items"].append(c)
    var jsondata = JSON.stringify(thedata, "  ")
    print(jsondata)
    if thedata["name"] != "":
        var f = FileAccess.open("res://levels/" + thedata["name"] + ".json", FileAccess.WRITE)
        f.store_string(jsondata)
        f.close()


func _load_pressed():
    $ScrollContainer/PanelContainer/VBoxContainer/load.disabled = true
    $ScrollContainer/PanelContainer/VBoxContainer/load.text = "Click New to load"
    var n = $ScrollContainer/PanelContainer/VBoxContainer/LineEdit.text
    var f = FileAccess.open("res://levels/" + n + ".json", FileAccess.READ)
    var t = f.get_as_text()
    f.close()
    var thedata = JSON.parse_string(t)
    $ScrollContainer/PanelContainer/VBoxContainer/LineEdit.text = thedata["name"]
    $ScrollContainer/PanelContainer/VBoxContainer/HBoxContainer/SpinBox.value = thedata["cycle"]
    var v2r := PackedVector2Array()
    for i in thedata["geom"]:
        v2r.append(Vector2(i[0], i[1]))
    geom.polygon = v2r
    geomdb.points = v2r
    for c in thedata["items"]:
        var h:Node2D = load(c["type"]).instantiate()
        levelc.add_child(h)
        h.process_mode = PROCESS_MODE_DISABLED
        h.position = Vector2(c["pos"][0], c["pos"][1])
        h.rotation = c["rot"]
        assets.append(h)


func _new_pressed():
    get_tree().reload_current_scene()


func _delete_point_pressed():
    var poly = geom.polygon
    if poly.size() > 0:
        poly.remove_at(poly.size() - 1)
        geom.polygon = poly
        geomdb.points = poly


func _delete_asset_pressed():
    if assets.size() > 0:
        assets[-1].queue_free()
        assets.remove_at(assets.size() - 1)


func _edit_pressed():
    placing = false
    $ScrollContainer/PanelContainer/VBoxContainer/HBoxContainer2/edit.disabled = true
    $ScrollContainer/PanelContainer/VBoxContainer/HBoxContainer2/place.disabled = false
    for i in assetButtons:
        i.disabled = true
    $HSeparator.visible = true
    $VSeparator.visible = true
    $Panel.visible = false


func _place_pressed():
    placing = true
    $ScrollContainer/PanelContainer/VBoxContainer/HBoxContainer2/edit.disabled = false
    $ScrollContainer/PanelContainer/VBoxContainer/HBoxContainer2/place.disabled = true
    for i in assetButtons:
        i.disabled = false
    $HSeparator.visible = false
    $VSeparator.visible = false
    $Panel.visible = true


func _rot_changed(value):
    if assets.size() > 0:
        assets[-1].rotation_degrees = value
