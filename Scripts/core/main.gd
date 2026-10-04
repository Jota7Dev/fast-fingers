extends Node2D

const SCENE_ASTEROID = preload("res://Scenes/asteroides/asteroide.tscn")

func _ready():
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = 2.0
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)

func _on_spawn_timer_timeout():
	var new_asteroid = SCENE_ASTEROID.instantiate()
	var x_random = randf_range(100, 1050)
	new_asteroid.position = Vector2(x_random, -50)
	add_child(new_asteroid)
