extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@export var interaction_radius:int = 10
var playerin:bool = false
var player

func _ready() -> void:
	collision_shape_2d.get_shape().radius = interaction_radius
	player = $"/root/Global".player

func _process(delta: float) -> void:
	if playerin:
		if Input.is_action_just_pressed("interact"):
			print("input pressed")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		playerin = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		playerin = false
