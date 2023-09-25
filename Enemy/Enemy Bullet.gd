extends Area2D

var speed = 10.0
var damage = 1.0
var velocity = Vector2.ZERO
var Effects = null
var Explosion = load("res://Effects/explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0,-speed).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	position = position + velocity


func _on_body_entered(_body):
	if _body.has_method("damage"):
		_body.damage(damage)
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var explosion = Explosion.instantiate()
		Effects.add_child(explosion)
		explosion.global_position = global_position
	queue_free()


func _on_timer_timeout():
	queue_free()

