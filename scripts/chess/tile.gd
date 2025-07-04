extends Node2D

@export var board_position := Vector2i(0, 0)
@onready var background := $Background

const TILE_SIZE := 24

func _ready():
	 # Position the collision shape
	$Area2D.position = Vector2(TILE_SIZE/2, TILE_SIZE/2)

func set_tile_color(is_light: bool) -> void:
	background.modulate = Color(0.85, 0.75, 0.6) if is_light else Color(0.4, 0.25, 0.1)

func highlight(color: Color) -> void:
	background.modulate = color

func reset_color():
	var is_light := (board_position.x + board_position.y) % 2 == 0
	set_tile_color(is_light)
	
