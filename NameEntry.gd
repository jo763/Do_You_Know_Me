extends Node2D
#var player_names = []

func _ready():
	$Background/Play.visible = false
	pass # Replace with function body.



func _button_Play():
	get_tree().change_scene_to_file("res://MainGame.tscn")
	print("GLOBAL.player_names: ", GLOBAL.player_names)
	pass # Replace with function body.


func _on_enter_button_pressed() -> void:
	GLOBAL.player_names.append($Background/TextBox.get_text())
	$Background/TextBox.text = ""
	print(GLOBAL.player_names)
	if len(GLOBAL.player_names) > 1:
		$Background/Play.visible = true
