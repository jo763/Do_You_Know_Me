extends Node2D
#var player_names = []

func _ready():
	pass # Replace with function body.



func _button_Play():
	get_tree().change_scene("res://MainGame.tscn")
	pass # Replace with function body.


func _on_EnterButton_pressed():
	GLOBAL.player_names.append($Background/TextBox.get_text())
	$Background/TextBox.text = ""
	print(GLOBAL.player_names)
	pass # Replace with function body.

