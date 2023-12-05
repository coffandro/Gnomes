extends Node3D

@export var Bullet: PackedScene
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


const ray_length = 1000

func _input(event):
	if event is InputEventMouseMotion:
		var mousepos = ScreenPointToRay()
		look_at(mousepos, Vector3.UP)
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var b = Bullet.instantiate()
		owner.add_child(b)
		b.transform = $BoomLocation.global_transform
		b.velocity = -b.transform.basis.z * b.muzzle_velocity

func ScreenPointToRay():
	var spaceState = get_world_3d().direct_space_state

	var mousePos = get_viewport().get_mouse_position()
	var camera = get_node("../Camera3D")
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd))
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()
