extends StaticBody3D

@onready var asteroid: StaticBody3D = $"."
@onready var collision: CollisionShape3D = $Collision

var rng = RandomNumberGenerator.new()
var rotationX = _move_rand()
var rotationY = _move_rand()
var rotationZ = _move_rand()
var translateZ = rng.randf() / 50


func _ready() -> void:
	var rscale = rng.randf_range(2.5, 10)
	asteroid.scale_object_local(Vector3(rscale, rscale, rscale))

func _move_rand() -> float:
	return deg_to_rad(rng.randf() if (rng.randi_range(0, 1)) else -rng.randf())

func _move_asteroid() -> void:
	rng.randomize()
	collision.rotate_y(rotationX)
	collision.rotate_x(rotationY)
	collision.rotate_z(rotationZ)
	asteroid.translate(Vector3(0, 0, translateZ))
