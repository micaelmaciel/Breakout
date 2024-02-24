extends CharacterBody2D

@export var initialSpeed: int = 100
@export var speedGain: int = 20

var score: int = GlobalProperties.score
var highestScore: int = GlobalProperties.highestScore

var ball_state: String = "initial"

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action("shoot") and ball_state == "initial":
		ball_state = "launched"
		velocity = Vector2(0, -1) * initialSpeed

#region ball starting
func initialize_ball() -> void:
	ball_state = "initial"

func reinitialize_ball() -> void:
	set_collision_mask_value(1, true)
	position.y = 458
	initialize_ball()
#endregion

#region ball collision
func bounce_ball(collision: KinematicCollision2D) -> void:
	velocity = velocity.bounce(collision.get_normal())

func react_collision(collision: KinematicCollision2D) -> void:
	var collider: Node = collision.get_collider()

	if (collider.is_in_group("brick")):
		collider.queue_free.call_deferred()
		velocity.y += speedGain * sign(velocity.y)
		GlobalProperties.score += 1
		bounce_ball(collision)
		$BrickHit.play(1.94)

	elif (collider is Player):
		velocity.x += 0.1
		var normal_x: float = collision.get_normal().x
		if (normal_x == 1 or sign(collision.get_normal().y) == 1):
			set_collision_mask_value(1, false)
		else:
			var normalizedDifference: float = (position - collider.position).normalized().x
			var speed: float = velocity.length()
			velocity.x = normalizedDifference * speed
			velocity = velocity.normalized() * speed
			bounce_ball(collision)
			velocity.y = abs(velocity.y) * -1
			$PaddleHit.play(0.53)

	else:
		bounce_ball(collision)
		$WallHit.play(0.12)
#endregion

func _ready() -> void:
	initialize_ball()

func _physics_process(delta: float) -> void:
	if ball_state == "initial":
		position.x = GlobalProperties.player.position.x
		return

	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if (collision):
		react_collision(collision)
	
	if (get_tree().get_first_node_in_group("brick") == null):
		GlobalProperties.emit_game_won()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:

	GlobalProperties.playerHealth -= 1
	if (GlobalProperties.playerHealth <= 0):
		GlobalProperties.emit_health_depleted()
		return
	
	reinitialize_ball()
