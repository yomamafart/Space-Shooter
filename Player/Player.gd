extends CharacterBody2D

var speed = 3
var max_speed = 1000
var rotate_speed = 0.06
var nose = Vector2(0,-60)
var Bullet = load("res://Player/bullet.tscn")
var Effects = null
var Explosion = load("res://Effects/explosion.tscn")
var health = 10

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("Forward"):
		to_return += Vector2(0,-1)
		$Exhaust.show()
	if Input.is_action_pressed("Left"):
		rotation -= rotate_speed
	if Input.is_action_pressed("Right"):
		rotation += rotate_speed
	return to_return.rotated(rotation) 

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	position.x = wrapf(position.x, 0 , 1152)
	position.y = wrapf(position.y, 0 , 648)
	velocity = velocity.normalized() * clamp(velocity.length(), 0,max_speed)
	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot"):
		var Effects = get_node_or_null("/root/Game/Effects")
		var bullet = Bullet.instantiate()
		bullet.rotation = rotation
		bullet.global_position = global_position + nose.rotated(rotation)
		if Effects != null:
			Effects.add_child(bullet)

func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instantiate()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			await explosion.animation_finished
		queue_free()


func _on_area_2d_body_entered(body):
	if body.name != "Player":
		damage(100)
