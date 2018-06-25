extends Spatial
var camera
var ray
var cursor_3d

func _ready():
	camera = $Camera
	ray = $Camera/RayCast

func _physics_process(delta):
	var ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var to = camera.project_local_ray_normal(mouse_pos) * ray_length
	ray.cast_to = to
	ray.force_raycast_update()
	if ray.is_colliding():
		cursor_3d = ray.get_collision_point()
	