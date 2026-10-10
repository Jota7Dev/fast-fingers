extends Node2D

const SCENE_ASTEROID = preload("res://Scenes/asteroides/asteroide.tscn")
var word_list: Array[String] = ["PROBANDO", "UNO", "DOS", "TRES", "CUATRO"]
var active_asteroid = null

func _ready():
	$CanvasLayer/TecladoUI.pressed_key.connect(_on_keyboard_pressed_key)
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = 2.0
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)

func _on_keyboard_pressed_key(letter: String):
	if not is_instance_valid(active_asteroid):
		_search_new_objetive()

	if is_instance_valid(active_asteroid):
		active_asteroid.process_letter(letter)

func _search_new_objetive():
	var max_y = -1000

	for child in get_children():
		if "target_word" in child:
			if child.position.y > max_y:
				max_y = child.position.y
				active_asteroid = child

func _on_spawn_timer_timeout():
	var new_asteroid = SCENE_ASTEROID.instantiate()
	new_asteroid.target_word = word_list.pick_random()
	var x_random = randf_range(80, 640)
	new_asteroid.position = Vector2(x_random, -50)
	add_child(new_asteroid)


func _on_killzone_area_entered(area: Area2D):
	if "target_word" in area:
		print("Vida restada")

		if active_asteroid == area:
			active_asteroid = null

		area.queue_free()
