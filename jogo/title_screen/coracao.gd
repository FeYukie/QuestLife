class_name CoracaoGUI extends Control

@onready var sprite_2d = $Sprite2D

var value : int = 2 :
	set( _value ):
		value = value
		update_sprite()
		
func update_sprite() -> void:
	sprite.frame = value
