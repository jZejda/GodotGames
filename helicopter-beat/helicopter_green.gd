extends CharacterBody2D

@export var move_speed: int = 200
## Radians per second when holding turn keys.
@export var turn_speed: float = PI
## Local direction that counts as “forward” before rotation (sprite nose). Default is screen-up.
@export var forward_local: Vector2 = Vector2.UP

@export var rotor_speed: float = TAU * 6.0  # 6 otáček za sekundu
@onready var rotor: Sprite2D = $HelicopterRottor

func _ready() -> void:
	position = Vector2(100, 100)


func _physics_process(delta: float) -> void:
	var turn := Input.get_axis("greenLeft", "greenRight")
	var throttle := Input.get_axis("greenDown", "greenForward")
	var strafe := Input.get_axis("greenStrafeLeft", "greenStrafeRight")

	rotation += turn * turn_speed * delta

	var forward_world := forward_local.normalized().rotated(rotation)
	var right_world := forward_world.rotated(PI / 2.0)

	var move_dir := forward_world * throttle + right_world * strafe
	velocity = move_dir.limit_length(1.0) * move_speed
	move_and_slide()
	
	rotor.rotation += rotor_speed * delta
