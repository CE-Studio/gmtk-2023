extends Node


var last := "res://levels/first.json"
var currentLevel := 1
var mus1 = preload("res://Music/Professor Kliq - Flip.mp3")
var mus2 = preload("res://Music/Professor Kliq - Nine.mp3")


func play_level_music():
    var music:AudioStreamPlayer = AudioStreamPlayer.new()
    add_child(music)
    if randf() > 0.5:
        music.stream = mus1
    else:
        music.stream = mus2
    music.play()
