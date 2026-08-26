extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@export var interaction_radius:int = 10

func _ready() -> void:
	collision_shape_2d.get_shape().radius = interaction_radius
