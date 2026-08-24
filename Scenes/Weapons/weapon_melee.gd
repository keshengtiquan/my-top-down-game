extends Weapon

class_name WeaponMelee
@onready var sprite: Sprite2D = %Sprite2D
@onready var slash: GPUParticles2D = %SlashParticle
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var slash_sound: AudioStreamPlayer = $SlashSound
@onready var cooldown: Timer = $Cooldown

var can_use: bool = true
var entities: Array[Node2D] 

func _ready() -> void:
	cooldown.wait_time = data.cooldown

func use_weapon() -> void:
	if not can_use: return
	can_use = false
	cooldown.start()
	animation_player.play("slash")
	slash_sound.play()
	
	for entity: Node2D in entities:
		Global.create_damage(data.damage, entity.global_position)
	
	slash.global_rotation = pivot.global_rotation
	slash.emitting = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		use_weapon()

func _on_cooldown_timeout() -> void:
	can_use = true
	animation_player.play("idle")


func _on_hit_box_body_entered(body: Node2D) -> void:
	if is_instance_valid(body):
		entities.append(body)


func _on_hit_box_body_exited(body: Node2D) -> void:
	if is_instance_valid(body):
		entities.erase(body)
