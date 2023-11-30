extends Node

@export var mob_scene: PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UserInterface/ProgressBar.value = Global.Health

# Called when an enemy hits the castle
func _on_castle_body_entered(body):
	if body.is_in_group("Enemies"):
		Global.Health -= 1
		body.queue_free()


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()

	var Castle_position = $Castle.position
	mob.initialize(mob_spawn_location.position, Castle_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
