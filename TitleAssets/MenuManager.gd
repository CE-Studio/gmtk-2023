extends Control


@onready var anim:AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
    anim.play("FadeIn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
    
func _load_game_scene():
    get_tree().change_scene_to_file("res://level_main.tscn")


func _on_play_button_pressed():
    anim.play("PlayFade")


func _on_options_button_pressed():
    anim.play("MenuToOptions")


func _on_credits_button_pressed():
    anim.play("MenuToCredits")


func _on_back_button_pressed():
    anim.play_backwards("MenuToOptions")


func _on_other_back_button_pressed():
    anim.play_backwards("MenuToCredits")


func _on_mus_slider_value_changed(value):
    ProjectSettings.set_setting("Gameplay/Audio/MusicVolume", value)


func _on_sfx_slider_value_changed(value):
    ProjectSettings.set_setting("Gameplay/Audio/SoundVolume", value)


func _on_shake_slider_value_changed(value):
    ProjectSettings.set_setting("Gameplay/ScreenShake", value)


func _on_invert_rotation_toggled(button_pressed):
    ProjectSettings.set_setting("Gameplay/InvertRotation", button_pressed)
