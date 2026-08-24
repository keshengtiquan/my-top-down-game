extends Control

class_name CharacterSelection
const PLAYER_CARD_SCENE = preload("uid://cvdk6j6wd7iu6")
const WEAPON_CARD_SCENE = preload("uid://s7kuav7o0ek8")

@export var selection_cursor: Texture2D
@export var players: Array[PlayerData]
@export var weapons: Array[WeaponData]
@onready var player_container: HBoxContainer = $PlayerContainer
@onready var weapon_container: HBoxContainer = $WeaponContainer
@onready var ui_sound: AudioStreamPlayer = $UISound
@onready var hover_sound: AudioStreamPlayer = $HoverSound



func _ready() -> void:
	Cursor.sprite.texture = selection_cursor
	load_selection_items()

func load_selection_items() -> void:
	for node in player_container.get_children():
		node.queue_free()
	for node in weapon_container.get_children():
		node.queue_free()
	# 玩家
	for data: PlayerData in players:
		var card: PlayerCard = PLAYER_CARD_SCENE.instantiate()
		card.pressed.connect(_on_player_card_pressed.bind(data, card))
		player_container.add_child(card)
		card.set_data(data)
	# 武器
	for data: WeaponData in weapons:
		var card: WeaponCard = WEAPON_CARD_SCENE.instantiate()
		card.pressed.connect(_on_weapon_card_pressed.bind(data,card))
		weapon_container.add_child(card)
		card.set_data(data)


func _on_play_button_pressed() -> void:
	if not Global.selected_player or not Global.selected_weapon:
		return
	ui_sound.play()
	Transition.transition_to("res://Scenes/Arena/arena.tscn")


func _on_back_button_pressed() -> void:
	ui_sound.play()
	Transition.transition_to("res://Scenes/ui/main_menu.tscn")

func _on_player_card_pressed(data: PlayerData, select_card: PlayerCard) -> void:
	ui_sound.play()
	Global.selected_player = data
	for card: PlayerCard in player_container.get_children():
		card.selector.visible = true if select_card == card else false


func _on_weapon_card_pressed(data: WeaponData, select_card: WeaponCard) -> void:
	ui_sound.play()
	Global.selected_weapon = data
	for card: WeaponCard in weapon_container.get_children():
		card.selector.visible = true if select_card == card else false


func _on_play_button_mouse_entered() -> void:
	hover_sound.play()


func _on_back_button_mouse_entered() -> void:
	hover_sound.play()
