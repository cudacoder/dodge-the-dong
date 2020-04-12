extends Area2D

signal hit
var screensize
export (int) var speed

func _ready():
	hide()
	screensize = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x,0, screensize.x)
	position.y = clamp(position.y,0, screensize.y)
	$Sprite.flip_h = velocity.x < 0
	$Sprite.flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	
func start(pos):
	show()
	set_position(pos)
