extends CharacterBody2D

@onready var player = get_node("/root/Main/Player")
@onready var nav_agent = $NavigationAgent2D

var speed = randf_range(100, 200)
var health = 5
var damage: = 1
var can_move = true


var current_velocity = Vector2.ZERO
var smooth_speed = 5.0 

func _ready():
	nav_agent.path_desired_distance = 1.0
	nav_agent.target_desired_distance = 4.0

func _physics_process(delta):
	if not player:
		return
	
	if nav_agent.is_navigation_finished() == false and can_move:
		look_at(player.global_position)
		var next_pos = nav_agent.get_next_path_position()
		var dir = (next_pos - global_position).normalized()
		var target_velocity = dir * speed
		velocity = velocity.slerp(target_velocity, smooth_speed * delta)
		move_and_slide()


func take_damage(amount: int):
	$DamagedSprite.show()
	await get_tree().create_timer(0.1).timeout
	$DamagedSprite.hide()
	health -= amount
	if health <= 0:
		die()

func die():
	WaveManager.enemies_left -= 1
	can_move = false
	$Death.play("die")
	
func _on_death_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die":
		queue_free()

func make_path():
	if player:
		nav_agent.target_position = player.global_position

func _on_timer_timeout():
	make_path()

@onready var player_damage_timer = get_node("/root/Main/Player/DamageTimer")

func _on_detect_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_damage_timer.start()
		body.take_damage(damage)

func _on_detect_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):

		player_damage_timer.stop()
		body.take_damage(damage)
