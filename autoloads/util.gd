extends Node

func world_to_screen(world_pos: Vector2, camera: Camera2D) -> Vector2:
	return (world_pos - camera.global_position) * camera.zoom + get_viewport().get_visible_rect().size / 2

func screen_to_world(screen_pos: Vector2, camera: Camera2D) -> Vector2:
	return (screen_pos - get_viewport().get_visible_rect().size / 2) / camera.zoom + camera.global_position
