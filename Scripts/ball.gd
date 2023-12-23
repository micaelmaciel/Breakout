extends CharacterBody2D

@export var initialSpeed: int = 100

func bounce_ball(collision: KinematicCollision2D) -> void:
	velocity = velocity.bounce(collision.get_normal())

#region ball starting
func initialize_ball() -> void:
	randomize()
	var randomSide: int = [1, -1].pick_random()
	var randomDirectionX: int = randi_range(1, 9) * randomSide
	velocity = Vector2(randomDirectionX, -1).normalized()
	velocity *= initialSpeed

func reinitialize_ball() -> void:
	pass
#endregion

func react_collision(collision: KinematicCollision2D) -> void:
	var collider: Node = collision.get_collider()

	if (collider.is_in_group("brick")):
		collider.queue_free.call_deferred()
		velocity.y *= 1.2
	elif (collider is Player):
		var normalizedDifference: float = (position - collider.position).normalized().x
		var speed: float = velocity.length()
		velocity.x = normalizedDifference * speed
		velocity = velocity.normalized() * speed
		
func _ready() -> void:
	initialize_ball()

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if (collision):
		react_collision(collision)
		bounce_ball(collision)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	GlobalProperties.emit_out_bounds()
	reinitialize_ball()