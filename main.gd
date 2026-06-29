extends Node

@onready var dan3_button = $"3dan"
@onready var dan4_button = $"4dan"
@onready var dan5_button = $"5dan"

func  _ready() -> void:
	pass

func _physics_process(delta: float) -> void:	
	pass

	

func _on_dan3_button_down() -> void:
	Global.dansu = 3
	get_tree().change_scene_to_file("res://3dan.tscn")
	pass # Replace with function body.

func _on_dan4_button_down() -> void:
	Global.dansu = 4
	get_tree().change_scene_to_file("res://4dan.tscn")
	pass # Replace with function body.
	
func _on_dan5_button_down() -> void:
	Global.dansu = 5
	get_tree().change_scene_to_file("res://5dan.tscn")
	pass # Replace with function body.
