extends CharacterBody2D

@export var initialSpeed: int = 100

func bounce_ball(collision: KinematicCollision2D) -> void:
    velocity = velocity.bounce(collision.get_normal())

func initialize_ball() -> void:
    randomize()
    var randomSide: int = -1 if(randi_range(0, 1) == 0) else 1
    var randomDirectionX: int = randi_range(1, 9) * randomSide
    velocity = Vector2(randomDirectionX, -1).normalized()
    velocity *= initialSpeed

func _ready() -> void:
    initialize_ball()

func _physics_process(delta) -> void:
    var collision: KinematicCollision2D = move_and_collide(velocity * delta)
    if (collision):
        bounce_ball(collision)