extends Node2D
class_name Arena
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var mana_bar: TextureProgressBar = %ManaBar
@export var arena_cursor: Texture2D

var grid: Dictionary[Vector2i, LevelRoom] = {}



func _ready() -> void:
	Cursor.sprite.texture = arena_cursor
	EventBus.on_player_health_update.connect(_on_player_health_update)
	load_game_selected()
	
func _on_player_health_update(current: float, max: float) ->void:
	health_bar.value = current / max

func load_game_selected() -> void:
	var player: Player = Global.get_player().instantiate()
	add_child(player)
	player.weapon_controller.equip_weapon()
