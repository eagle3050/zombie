extends Area2D

var speed = 750
var direction
var damage: = 1

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free()
	else:
		queue_free()
