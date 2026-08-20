extends CharacterBody2D

class_name Player
@export var data: PlayerData
@onready var visuals: Node2D = $Visuals
@onready var anim_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent

var can_move = true
var direction: Vector2
var movement: Vector2

func _ready() -> void:
	health_component.initHealth(data.max_hp)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		health_component.take_damage(1)

func _physics_process(delta: float) -> void:
	if not can_move:
		return 
	direction = Input.get_vector("move_left","move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		movement = direction * data.move_speed
		anim_sprite.play("move")
	else: 
		movement = Vector2.ZERO
		anim_sprite.play('idle')
	velocity = movement
	move_and_slide() 
	rotate_player()

func rotate_player() -> void:
	if direction != Vector2.ZERO:
		if direction.x > 0.1:
			visuals.scale = Vector2(1.25, 1.25) 
		else:
			visuals.scale = Vector2(-1.25, 1.25) 


func _on_health_component_on_unit_damaged(amount: float) -> void:
	EventBus.on_player_health_update.emit(health_component.current_health, data.max_hp)


func _on_health_component_on_unit_dead() -> void:
	queue_free()


func _on_health_component_on_unit_healed(amount: float) -> void:
	pass # Replace with function body.
