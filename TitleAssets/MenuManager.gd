extends Control


@onready var anim:AnimationPlayer = $AnimationPlayer
@onready var audioButton:AudioStreamPlayer = $ButtonAudio
@onready var audioWhoosh:AudioStreamPlayer = $WhooshAudio
@onready var audioMusic:AudioStreamPlayer = $MenuMusic

var sfxMenuButton = preload("res://Sounds/MenuButton.ogg")
var sfxBackButton = preload("res://Sounds/MenuButtonBack.ogg")
var sfxSideWhoosh = preload("res://Sounds/MenuWhoosh.ogg")
var sfxPlayWhoosh = preload("res://Sounds/PlayWhoosh.ogg")
var sfxSliderTick = preload("res://Sounds/MenuTick.ogg")

@export var musVolumeMult:float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
    anim.play("FadeIn")
    audioMusic.volume_db = lerp(-80, 24, ProjectSettings.get_setting("Gameplay/Audio/MusicVolume"))
    audioButton.volume_db = lerp(-80, 24, ProjectSettings.get_setting("Gameplay/Audio/SoundVolume"))
    audioWhoosh.volume_db = lerp(-80, 24, ProjectSettings.get_setting("Gameplay/Audio/SoundVolume"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if musVolumeMult < 1:
        var initialVal = ProjectSettings.get_setting("Gameplay/Audio/MusicVolume")
        audioMusic.volume_db = lerp(-80, 24, initialVal * musVolumeMult)
    
    
func _load_game_scene():
    Glob.play_level_music()
    get_tree().change_scene_to_file("res://level_main.tscn")


func _play_button_sound(sfx):
    audioButton.stream = sfx
    audioButton.play()
    
    
func _play_whoosh_sound(sfx):
    audioWhoosh.stream = sfx
    audioWhoosh.play()


func _on_play_button_pressed():
    anim.play("PlayFade")
    _play_button_sound(sfxMenuButton)
    _play_whoosh_sound(sfxPlayWhoosh)


func _on_options_button_pressed():
    anim.play("MenuToOptions")
    _play_button_sound(sfxMenuButton)
    _play_whoosh_sound(sfxSideWhoosh)


func _on_credits_button_pressed():
    anim.play("MenuToCredits")
    _play_button_sound(sfxMenuButton)
    _play_whoosh_sound(sfxSideWhoosh)


func _on_back_button_pressed():
    anim.play_backwards("MenuToOptions")
    _play_button_sound(sfxBackButton)
    _play_whoosh_sound(sfxSideWhoosh)


func _on_other_back_button_pressed():
    anim.play_backwards("MenuToCredits")
    _play_button_sound(sfxBackButton)
    _play_whoosh_sound(sfxSideWhoosh)


func _on_mus_slider_value_changed(value):
    ProjectSettings.set_setting("Gameplay/Audio/MusicVolume", value)
    _play_button_sound(sfxSliderTick)
    var newAudioValue = lerp(-80, 24, value)
    audioMusic.volume_db = newAudioValue


func _on_sfx_slider_value_changed(value):
    ProjectSettings.set_setting("Gameplay/Audio/SoundVolume", value)
    _play_button_sound(sfxSliderTick)
    var newAudioValue = lerp(-80, 24, value)
    audioButton.volume_db = newAudioValue
    audioWhoosh.volume_db = newAudioValue


func _on_shake_slider_value_changed(value):
    ProjectSettings.set_setting("Gameplay/ScreenShake", value)
    _play_button_sound(sfxSliderTick)


func _on_invert_rotation_toggled(button_pressed):
    ProjectSettings.set_setting("Gameplay/InvertRotation", button_pressed)
    _play_button_sound(sfxSliderTick)
