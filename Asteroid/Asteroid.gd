extends CharacterBody2D

var intial_speed = 30.0

func _ready():
	velocity = Vector2(0,intial_speed*randf()).rotated(2*PI*randf())

func _physics_process(_delta):
	move_and_slide()
	position.x = wrapf(position.x, 0 ,1152)
	position.y = wrapf(position.y, 0 ,648)
