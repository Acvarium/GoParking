extends Spatial
var camera
var ray
var cursor_3d
var global


func _ready():
	global = get_node("/root/global")
	camera = $Camera
	ray = $Camera/RayCast
	var levelObj = load(global.getLevel())
	add_child(levelObj.instance())

func engine(on):
	if on:
		$sounds/engine2.play()
	else:
		$sounds/engine2.stop()
		

func crash():
	$sounds/crash.play()
	$timers/alarm.start()
	$crash.visible = true

func _physics_process(delta):
	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var to = camera.project_local_ray_normal(mouse_pos) * ray_length
	ray.cast_to = to
	ray.force_raycast_update()
	if ray.is_colliding():
		cursor_3d = ray.get_collision_point()
	
func _on_gate_body_entered(body):
	if body.is_in_group("main_car"):
		$sounds/victory.play()
		$victory.visible = true

func _on_alarm_timeout():
	$sounds/alarm01.play()
	$sounds/alarm02.play()

func _on_restartButton_pressed():
	get_tree().reload_current_scene()


func _on_next_pressed():
	global.nextLevel()
	get_tree().reload_current_scene()
