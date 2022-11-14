extends Node2D

onready var nav2D : Navigation2D = $Navigation2D
onready var player : KinematicBody2D = $player

enum{IDLE, MOVE, INTERACT}



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#handles player on click movement input
func _input(event):
	if !Input.is_action_pressed("ui_leftMouseClick"):
		return
	#Creates a nav2D path between player current position and mouse position on click
	var new_path = nav2D.get_simple_path(player.get_global_position(), get_global_mouse_position())
	
	#sets path for player node
	player.path = new_path
	
	#Triggers player Move state
	player.changeState(MOVE)
	

#Defines behavior for interactables on click
func _on_Interactable_input_event(viewport, event, shape_idx):
	if !Input.is_action_pressed("ui_leftMouseClick"):
		return
