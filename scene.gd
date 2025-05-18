extends Node3D

@onready var control: Control = $CanvasLayer/Control
@onready var timer: Timer = $CanvasLayer/Timer
@onready var space_ship: Node3D = $SpaceShip

var rng = RandomNumberGenerator.new()
var list = []

const scene = preload("res://Asteroid/asteroid.tscn")


func _ready() -> void:
	_create_asteriods(5)

func _handle_asteroids() -> void:
	for i in list:
		if i.position.z >= space_ship.position.z:
			list.erase(i)
			remove_child(i)
			i.queue_free()
	_create_asteriods(5)

func _create_asteriods(quantity: int) -> void:
	for i in quantity:
		var asteroid = scene.instantiate()
		timer.connect("timeout", asteroid.move_asteroid)
		asteroid.translate(Vector3(rng.randf_range(-100, 100), rng.randf_range(-50, 50), 0))
		add_child(asteroid)
		list.append(asteroid)
