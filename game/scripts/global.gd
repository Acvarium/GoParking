extends Node
var current_scene = null
const maxLevel = 1
var level = 0

func nextLevel():
	level += 1
	if level > maxLevel:
		level = 0

func getLevel():
	var levelName = "res://levels/level" + str(level) +".tscn"
	return levelName

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )

func goto_scene(path):
	call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene( current_scene )