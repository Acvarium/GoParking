extends Camera

var ray
var cursor3D = Vector3()

func _ready():
	ray = $RayCast

func _process(delta):
	var ray_lenght = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var to = project_local_ray_normal(mouse_pos) * ray_lenght
#	to = to.rotated(Vector3(1,0,0), PI/2)
	ray.cast_to = to
	ray.force_raycast_update()
	if ray.is_colliding():
		cursor3D = ray.get_collision_point()