extends Node2D
class_name Arena
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var mana_bar: TextureProgressBar = %ManaBar
@export var arena_cursor: Texture2D

func _ready() -> void:
	Cursor.sprite.texture = arena_cursor
	EventBus.on_player_health_update.connect(_on_player_health_update)
	
func _on_player_health_update(current: float, max: float) ->void:
	health_bar.value = current / max
	
