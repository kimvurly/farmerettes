extends Control
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.play("default")

func _on_button_pressed():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main_scene/main_scene.tscn")
	
