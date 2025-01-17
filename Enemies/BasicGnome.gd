extends CharacterBody3D


const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# This function will be called from the Main scene.
func initialize(start_position, player_position, SPEED):
	$Pivot/StrongGnome/AnimationPlayer.play("Run")
	# We position the mob by placing it at start_position
	# and rotate it towards player_position, so it looks at the player.
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotate this mob randomly within range of -90 and +90 degrees,
	# so that it doesn't move directly towards the player.
	# rotate_y(randf_range(-PI / 8, PI / 8))

	# We calculate a forward velocity that represents the speed.
	velocity = Vector3.FORWARD * SPEED
	# We then rotate the velocity vector based on the mob's Y rotation
	# in order to move in the direction the mob is looking.
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _physics_process(_delta):
	move_and_slide()

func hit():
	Global.Score += 1
	queue_free()
