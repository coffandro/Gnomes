extends Node

@export var mob_scene: PackedScene

var Round = 0
var MobSpeed = 5.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Castle/UserInterface/HealthBar.value = Global.Health
	$Castle/UserInterface/HealthLabel.text = "Armor: %s" % Global.Health
	$UserInterface/ScoreLabel.text = "Souls: %s" % Global.Score
	$UserInterface/DeathScreen/TotalScoreLabel.text = "You collected %s souls" % Global.Score
	print("Round %s" % Round)
	print($MobTimer.get_time_left())
	print($RoundTimer.get_time_left())

# Called when an enemy hits the castle
func _on_castle_body_entered(body):
	if body.is_in_group("Enemies"):
		if Global.Death == false:
			Global.Health -= 1
			body.queue_free()
			if Global.Health == 0:
				Global.Dead()
		else:
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
	mob.initialize(mob_spawn_location.position, Castle_position, MobSpeed)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_round_timer_timeout():
	if Round == 0:
		#$RoundTimer.wait_time = 5
		$MobTimer.start()
		$RoundTimer.start()
	elif Round == 1:
		MobSpeed = 7.5
	elif Round == 2:
		MobSpeed = 10
	elif Round == 3:
		MobSpeed = 12.5
	elif Round == 4:
		MobSpeed = 15
	Round += 1


func _on_shop_button_pressed():
	Global.Change_Scene("Shop", 0)


func _on_retry_button_pressed():
	get_tree().reload_scene()
