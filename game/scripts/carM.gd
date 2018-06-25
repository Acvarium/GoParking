extends KinematicBody

var isPressed = false
var cam 
var maskVec = Vector3()
var clickOffset = Vector3()

func _ready():
	set_physics_process(false)
	cam = get_node("../Camera")
	maskVec = Vector3(1,0,0).rotated(Vector3(0,1,0), rotation.y).abs()

func _physics_process(delta):
	if isPressed:
		var slideVec = ((cam.cursor3D + clickOffset) - translation) * maskVec * 0.1
		move_and_collide(slideVec)

func _on_car_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			isPressed = true
			set_physics_process(true)
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			clickOffset = translation - cam.cursor3D 
		else:
			isPressed = false
			set_physics_process(false)
			print(translation)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Area_body_entered(body):
	if body != self:
		isPressed = false
		set_physics_process(false)
		print("aaaaaaaaaaaaaaaaaaaa");
