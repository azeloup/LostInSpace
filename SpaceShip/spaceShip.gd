extends Node3D

@onready var label1: Label = $CanvasLayer/MarginContainer/VBoxContainer/Label
@onready var label2: Label = $CanvasLayer/MarginContainer/VBoxContainer/Label2
@onready var label3: Label = $CanvasLayer/MarginContainer/VBoxContainer/Label3
@onready var label4: Label = $CanvasLayer/MarginContainer/VBoxContainer/Label4
@onready var node: Node3D = $"."
@onready var body: MeshInstance3D = $MeshInstance3D
@onready var menu: Control = $"../../."
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

const SPEED = 0.5
const MAX_HP = 100.0
const DAMAGE = 25.0

var score = 0

var hp_body = MAX_HP
var hp_left = MAX_HP
var hp_right = MAX_HP

var lastDir = 0
var lastYDir = 0
var last = Vector3()


func _ready():
	label1.text = "Score: %d" % score
	label2.text = "Body hp: %d" % hp_body
	label3.text = "Right Wing hp: %d" % hp_right
	label4.text = "Left Wing hp: %d" % hp_left

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")
	var direction := Vector3(-input_dir.y, 0, -input_dir.x).normalized()

	var maneuverability = clamp((hp_left + hp_right) / MAX_HP * 2, 0.0, 1.0)
	var rot = 10 * PI / 180

	if direction != last:
		var tmp = direction
		tmp.z *= maneuverability
		body.rotate(last, rot)
		body.rotate(-tmp, rot)
		last = tmp

	if (node.position.x + (-direction.z * SPEED * maneuverability) > 60
		or node.position.x + (-direction.z * SPEED * maneuverability) < -60):
		direction.z = 0
	if (node.position.y + (direction.x * SPEED) > 30
		or node.position.y + (direction.x * SPEED) < -30):
		direction.x = 0

	node.translate(Vector3(direction.z * maneuverability, direction.x, 0) * SPEED)

func damage_body(body: Node3D) -> void:
	audio.play()
	hp_body = max(hp_body - DAMAGE, 0)
	label2.text = "Body hp: %d" % hp_body
	if (hp_body == 0):
		menu.end_game(score)

func damage_left(bosy: Node3D) -> void:
	audio.play()
	hp_left = max(hp_left - DAMAGE, 0)
	label3.text = "Right Wing hp: %d" % hp_left

func damage_right(body: Node3D) -> void:
	audio.play()
	hp_right = max(hp_right - DAMAGE, 0)
	label4.text = "Left Wing hp: %d" % hp_right

func update_score() -> void:
	score += 1
	label1.text = "Score: %d" % score
