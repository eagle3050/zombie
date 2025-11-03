extends Node


@onready var player = get_node("/root/Main/Player")

func _ready() -> void:
	
	spawn_wave()

func spawn_wave():
	for enemy in WaveManager.current_wave:
		
		spawn_enemy()

func spawn_enemy():
	print(WaveManager.enemies_left)
	WaveManager.enemies_left += 1
	print("spawing")
	
	var enemy = WaveManager.enemy_scene.instantiate()
	add_child(enemy)
	var rect: Rect2 = $CollisionShape2D.shape.get_rect()
	var random_x = randf_range(rect.position.x, rect.position.x + rect.size.x)
	var random_y = randf_range(rect.position.y, rect.position.y + rect.size.y)
	var random_point_local = Vector2(random_x, random_y)
	var random_point_global = $CollisionShape2D.global_position + random_point_local
	enemy.global_position = random_point_global

func _physics_process(delta: float) -> void:
	if WaveManager.enemies_left == 0:
		print("Ya")
		WaveManager.current_wave += 1
		spawn_wave()
