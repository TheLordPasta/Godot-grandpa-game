extends Node2D
var trampoline_scene: PackedScene = load("res://scenes/trampoline.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_grandpa_trampoline(pos):
	var trampoline = trampoline_scene.instantiate()
	$PlayerObjects.add_child(trampoline)
	trampoline.position = pos
