extends Control


@onready var anim:AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
