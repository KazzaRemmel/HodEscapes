extends CharacterBody2D

const GRAVITY:=10
var jump_force := 400
var speed := 200

@onready var anim = $anim as AnimatedSprite2D
@onready  var screen_size = get_viewport_rect().size
@onready var jump_sound = $jump
@onready var death_sound = $death
@onready var bg_music = $"../bg_music"

func move(delta):
	var input_direction = Input.get_axis("ui_left", "ui_right")

	if input_direction != 0:
		velocity.x = lerp(velocity.x, input_direction*speed, 0.5)
		anim.scale.x = input_direction
	else:
		velocity.x = lerp(velocity.x,0.0,0.5)

	velocity.y += GRAVITY

	var collision = move_and_collide(velocity*delta)

	if is_on_floor():
		anim.play('idle')
	else:
		anim.play('fall')

	if collision:
		jump_sound.play()
		velocity.y = -jump_force * collision.get_collider().jump_force
		if collision.get_collider().has_method('response'):
			collision.get_collider().response()

func _physics_process(delta:float)->void:
	move(delta)

	position.x = wrapf(position.x, 0, screen_size.x)

func die():
	print('Player died')
	bg_music.stop()
	#death_sound.play()
	#get_tree().reload_current_scene()
	velocity = Vector2.ZERO
	set_collision_mask_value(2,false)
	set_collision_mask_value(3,false)

