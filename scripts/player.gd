extends CharacterBody2D

const accelaration = 800
const friction = 500
const max_spd = 120

enum {idle, run}
var state = idle
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$"/root/Global".register_player(self)
	

func _physics_process(delta: float) -> void:
	move(delta)
	animate()

func move(delta):
	var input_vector = Input.get_vector("left","right","up","down")
	if input_vector == Vector2.ZERO:
		state = idle
		apply_friction(friction * delta)
	else:
		state = run
		apply_movement(input_vector*accelaration * delta)
	move_and_slide()

func apply_friction(amount) -> void :
	if velocity.length() > amount:
		velocity -= velocity.normalized()*amount
	else:
		velocity = Vector2.ZERO

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(max_spd)

func animate() -> void:
	var input_vector = Input.get_vector("left","right","up","down")
	var angle = rad_to_deg(input_vector.angle())
	if angle == 0:
		animation_player.play("player_animation/run_right")
	elif angle == 45:
		animation_player.play("player_animation/run_right_up")
	elif angle == 90:
		animation_player.play("player_animation/run_up")
	
	pass
