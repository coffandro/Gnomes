extends Node

var Health = 10
var Score = 0
var Death = false

func Dead():
	get_node("/root/Main/MobTimer").stop()
	get_node("/root/Main/UserInterface/ScoreLabel").hide()
	get_node("/root/Main/UserInterface/DeathScreen").show()
	Death = true

func Change_Scene(Scene, animation):
	get_tree().change_scene_to_file("res://%s.tscn" % Scene)
