extends Node3D

@onready var node = $"."
@onready var body = $"3Dmodel"
@onready var cam = $Camera3D
@onready var body_area = $BodyArea
@onready var left_area = $LeftArea
@onready var right_area = $RightArea

const SPEED = 0.5
const MAX_HP = 100.0

var hp_body = MAX_HP
var hp_left = MAX_HP
var hp_right = MAX_HP

var lastDir = 0
var lastYDir = 0

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")
	var direction := Vector3(input_dir.x, input_dir.y, 0).normalized()

	var left_factor = clamp(hp_left / MAX_HP, 0.0, 1.0)
	var right_factor = clamp(hp_right / MAX_HP, 0.0, 1.0)
	var maneuverability = (left_factor + right_factor) / 2.0
	
	var z_rot = 10 * PI / 180 * maneuverability
	var cam_z_rot = 5 * PI / 180 * maneuverability
	var x_rot = 10 * PI / 180
	var cam_x_rot = 5 * PI / 180

	if direction:

		if direction.x != lastDir:
			body.rotate_z(-lastDir * z_rot)
			body.rotate_z(direction.x * z_rot)
			cam.rotate_z(-lastDir * cam_z_rot)
			cam.rotate_z(direction.x * cam_z_rot)
			lastDir = direction.x

		if direction.y != lastYDir:
			body.rotate_x(lastYDir * x_rot)
			body.rotate_x(-direction.y * x_rot)
			cam.rotate_x(lastYDir * cam_x_rot)
			cam.rotate_x(-direction.y * cam_x_rot)
			lastYDir = direction.y

	else:
		body.rotate_z(-lastDir * z_rot)
		cam.rotate_z(-lastDir * cam_z_rot)
		lastDir = 0

		body.rotate_x(lastYDir * x_rot)
		cam.rotate_x(lastYDir * cam_x_rot)
		lastYDir = 0

	node.translate(direction * SPEED * maneuverability)

func damage_body(amount: float) -> void:
	hp_body = max(hp_body - amount, 0)

func damage_left(amount: float) -> void:
	hp_left = max(hp_left - amount, 0)

func damage_right(amount: float) -> void:
	hp_right = max(hp_right - amount, 0)
