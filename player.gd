extends CharacterBody2D

const accelaration = 800
const friction = 500
const max_spd = 120

enum {idle, run}
var state = idle

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]

var blend_position: Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/run/run_bs2d/blend_position"
]
var animTree_state_keys = [
	"idle",
	"run"
]

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
		blend_position = input_vector
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
	state_machine.travel(animTree_state_keys[state])
	animation_tree.set(blend_pos_paths[state],blend_position)
