extends Node2D
class_name Arena
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var mana_bar: TextureProgressBar = %ManaBar


func _ready() -> void:
	EventBus.on_player_health_update.connect(_on_player_health_update)
	
func _on_player_health_update(current: float, max: float) ->void:
	health_bar.value = current / max
	
