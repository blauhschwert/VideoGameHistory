class_name PlayerRacket
extends CharacterBody2D

enum PlayerState {IDLE,MOVEMENT,PRE_SHOOTING,SHOOTING,REPOSITION,BOUNCE}

@export_category("Player Gameplay")
## The character's maximum speed in pixels per second.
@export var max_speed := 1000.0
## A multiplier we use to limit the character's acceleration and deceleration.
@export var drag := 20.0

var _cur_state : PlayerState = PlayerState.IDLE

func _init():
	# Hides the Mouse Couror.
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _ready():
	pass

func _input(event):
	if event is InputEventMouseMotion:
		_cur_state = PlayerState.MOVEMENT
	elif event is InputEventMouseButton:
		if event.is_action_pressed("shooting"):
			_cur_state = PlayerState.PRE_SHOOTING
		elif event.is_action_released("shooting"):
			_cur_state = PlayerState.SHOOTING
		

func _physics_process(_delta):
	match _cur_state:
		PlayerState.IDLE:
			pass
		PlayerState.MOVEMENT:
			position = _change_player_position()
		PlayerState.PRE_SHOOTING:
			pass

	_change_state_text()


func _change_player_position() -> Vector2:
	return get_global_mouse_position()

func _change_state_text() -> void:
	match _cur_state:
		PlayerState.IDLE:
			$DebugState.text = "IDLE"
		PlayerState.MOVEMENT:
			$DebugState.text = "MOVEMENT"
		PlayerState.PRE_SHOOTING:
			$DebugState.text = "PRE_SHOOTING"
		PlayerState.SHOOTING:
			$DebugState.text = "SHOOTING"
		PlayerState.REPOSITION:
			$DebugState.text = "REPOSITION"
		PlayerState.BOUNCE:
			$DebugState.text = "BOUNCE"
