extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2

@onready var hud_life: Label = %HUDLife
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var jumps = 0
var direction = 0
var isDead = false
var life = 1

func _ready():
	updateLife()
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps = 0
	
	if not isDead:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and jumps < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jumps += 1
		# Handle movement.
		direction = Input.get_axis("move_left", "move_right")
		
		#flip sprites
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		#play animations
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			if velocity.y > 1:
				animated_sprite.play("fall")
			elif jumps > 1:
				animated_sprite.play("doubleJump")
			else:
				animated_sprite.play("jump")
		
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		move_and_slide()

func addLife(amount = 1):
	life += amount
	updateLife()

func removeLife(amount = 1):
	life -= amount
	updateLife()
	if life <= 0 && isDead == false:
		isDead = true
		animated_sprite.play("dead")
		Engine.time_scale = 0.5
		timer.start()

func updateLife():
	hud_life.text = "Vidas: " + str(life)

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
