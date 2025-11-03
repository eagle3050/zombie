extends CharacterBody2D

var speed = 250
var bullet_scene = preload("res://bullet.tscn")
var health = 10

func _physics_process(_delta: float) -> void:
	$FlashParticles.global_position = $Marker2D.global_position
	handle_shooting()
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * speed
	move_and_slide()
	

func take_damage(amount: int):
	$DamagedSprite.show()
	await get_tree().create_timer(0.1).timeout
	$DamagedSprite.hide()
	health -= amount
	if health <= 0:
		die()

func die():
	hide()


func handle_shooting():
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.direction = global_transform.x
	bullet.rotation = $Marker2D.rotation
	
	bullet.global_position = $Marker2D.global_position
	get_parent().add_child(bullet)
	$FlashParticles.emitting = true
	await get_tree().create_timer(0.01).timeout
	$FlashParticles.emitting = false


func _on_damage_timer_timeout() -> void:
	take_damage(1)
