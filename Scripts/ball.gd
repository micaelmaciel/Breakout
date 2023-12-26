extends CharacterBody2D

@export var initialSpeed: int = 100
var score: int = GlobalProperties.score
var highestScore: int = GlobalProperties.highestScore


#region ball starting
func initialize_ball() -> void:
	randomize()
	var randomSide: int = [1, -1].pick_random()
	var randomDirectionX: int = randi_range(1, 9) * randomSide
	velocity = Vector2(randomDirectionX, -1).normalized()
	velocity *= initialSpeed

func reinitialize_ball() -> void:
	set_collision_mask_value(1, true)
	position = Vector2(463, 363)
	initialize_ball()
#endregion

#region ball collision
func bounce_ball(collision: KinematicCollision2D) -> void:
	velocity = velocity.bounce(collision.get_normal())

func react_collision(collision: KinematicCollision2D) -> void:
	var collider: Node = collision.get_collider()

	if (collider.is_in_group("brick")):
		collider.queue_free.call_deferred()
		velocity.y *= 1.2
		GlobalProperties.score += 1
		bounce_ball(collision)
	elif (collider is Player):
		var normal_x: float = collision.get_normal().x
		if (abs(abs(normal_x) - 1) < 0.0001):
			set_collision_mask_value(1, false)
		else:
			var normalizedDifference: float = (position - collider.position).normalized().x
			var speed: float = velocity.length()
			velocity.x = normalizedDifference * speed
			velocity = velocity.normalized() * speed
			bounce_ball(collision)
	else:
		bounce_ball(collision)
#endregion

func _ready() -> void:
	initialize_ball()

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if (collision):
		react_collision(collision)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	GlobalProperties.highestScore = max(GlobalProperties.highestScore, GlobalProperties.score)
	GlobalProperties.score = 0
	GlobalProperties.emit_out_bounds()
	reinitialize_ball()