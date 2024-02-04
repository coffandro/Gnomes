extends Node

var Health = 10
var Score = 0
var Death = false

func Dead():
	get_node("/root/Main/MobTimer").wait_time = 0.001
	get_node("/root/Main/UserInterface/ScoreLabel").hide()
	get_node("/root/Main/UserInterface/DeathScreen").show()
	Death = true
