extends KinematicBody
var isPressed = false
var main_node
var offset = Vector3()
var mask = Vector3()
var hasBiper = false

func _ready():
	set_physics_process(false)
	main_node = get_node("/root/main")
	mask = Vector3(1,0,0).rotated(Vector3(0,1,0), rotation.y).abs()
	if $frontRay and $bip and $bipTimer:
		hasBiper = true
	
func _physics_process(delta):
	if isPressed:
		var slideVec = ((main_node.cursor_3d + offset) - translation) * mask * 0.1
		move_and_collide(slideVec)
		var bipOn = false
		if hasBiper:
			var ray = $frontRay
			if $backRay.is_colliding() and !ray.is_colliding():
				ray = $backRay
			elif $backRay.is_colliding() and ray.is_colliding():
				var d0 = ray.global_transform.origin.distance_to(ray.get_collision_point())
				var d1 = $backRay.global_transform.origin.distance_to($backRay.get_collision_point())
				if d1 <= d0:
					ray = $backRay
			if ray.is_colliding():
				var dist = ray.global_transform.origin.distance_to(ray.get_collision_point())
				dist *= 3
				$bipTimer.wait_time = dist
				if $bipTimer.is_stopped():
					$bipTimer.start()
			else:
				if !$bipTimer.is_stopped():
					$bipTimer.stop()

func _on_car_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			isPressed = true
			set_physics_process(true)
			offset = translation - main_node.cursor_3d
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#			main_node.engine(true)
		else:
			isPressed = false
			set_physics_process(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#			main_node.engine(false)
			if hasBiper:
				if !$bipTimer.is_stopped():
					$bipTimer.stop()

func _on_Area_body_entered(body):
	if body != self:
		isPressed = false
		set_physics_process(false)
		if hasBiper:
			if !$bipTimer.is_stopped():
				$bipTimer.stop()
		main_node.crash()


func _on_bipTimer_timeout():
	$bip.play()
