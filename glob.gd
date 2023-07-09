extends Node


var last := "res://levels/first.json"
var currentLevel := 1
var mus1 = preload("res://Music/Professor Kliq - Flip.mp3")
var mus2 = preload("res://Music/Professor Kliq - Nine.mp3")


func play_level_music():
    var music:AudioStreamPlayer = AudioStreamPlayer.new()
    add_child(music)
    music.volume_db = lerp(-80, 24, ProjectSettings.get_setting("Gameplay/Audio/MusicVolume"))
    var startPos = 0
    if randf() > 0.5:
        music.stream = mus1
        var newPos = [0, 29.565, 80.563]
        newPos.shuffle()
        startPos = newPos[0]
    else:
        music.stream = mus2
        var newPos = [0, 28.861, 121.141, 179.132]
        newPos.shuffle()
        startPos = newPos[0]
    music.play(startPos)
