extends Sprite2D


const APATH = "res://game components/saw.tscn"
var part = preload("res://LevelAssets/deathpart.tscn")


func _process(delta):
    rotate(-delta * PI)


func _on_area_2d_body_entered(body):
    if body is Player:
        $"/root/Node2D/Node2D/RigidBody2D2".lost()
        var h = part.instantiate()
        h.position = body.position
        $"../../".add_child(h)
        body.queue_free()
