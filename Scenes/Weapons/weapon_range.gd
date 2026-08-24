extends Weapon

class_name WeaponRange
@onready var sprite: Sprite2D = %Sprite2D
@onready var fire_pos: Marker2D = %FirePos

var direction: Vector2
var cooldown: float

func _process(delta: float) -> void:
	rotate_weapon()
	cooldown -= delta
	if Input.is_action_pressed("shoot"):
		if cooldown <= 0:
			use_weapon() 
			cooldown = data.cooldown

func use_weapon() -> void:
	var bullte: Bullet = data.bullet_scene.instantiate()
	bullte.setup(data)
	bullte.global_position = fire_pos.global_position
	bullte.global_rotation = pivot.global_rotation + deg_to_rad(randf_range(-data.spread, data.spread))
	get_tree().root.add_child(bullte)

func rotate_weapon() -> void:
	direction = get_global_mouse_position() - global_position
	sprite.flip_v = direction.x < 0
