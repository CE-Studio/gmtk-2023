extends Button
class_name AssetButton


@export_file("*.tscn") var apath:String
var asset:Node2D


func _ready():
    asset = load(apath).instantiate()
    asset.process_mode = PROCESS_MODE_DISABLED
    $Node2D.add_child(asset)
    asset.position = Vector2.ZERO


func _on_pressed():
    $"/root/edit".add_asset(apath)
