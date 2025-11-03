extends Node

var current_wave: = 1
var enemies_left: int
@onready var enemy_scene = preload("res://zombie.tscn")
@onready var player = get_node("/root/Main/Player")
