extends KinematicBody2D

var path : PoolVector2Array

onready var nav2D : Navigation2D = $"../Navigation2D"
onready var interactableObjects : Area2D = $"../interactableObjects"

export var speed = 200

#Defines default state and possible player states
enum{IDLE, MOVE, INTERACT}
var state = IDLE

var will_interact : bool
var interactable

#========================== END OF VARIABLE DEFINITION =============================#


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var move_distance = speed * delta
	
	#Executes State behavior
	match state:
		IDLE:
			pass
		MOVE:
			movePath(move_distance)


#Defines player movement
func movePath(move_distance):
	
	var startingPoint : = position
	
	#Flips sprite x axis
	if (startingPoint.x < path[0].x):
		get_node("playerSprite").set_flip_h(false)
	if (startingPoint.x > path[0].x):
		get_node("playerSprite").set_flip_h(true)
	
	#Iterates through player path
	for i in range (path.size()):
		var distance_to_next = startingPoint.distance_to(path[0])
		 
		#Interpolates position coordinates between current and next point in path array
		if (move_distance <= distance_to_next):
			position  = startingPoint.linear_interpolate(path[0], move_distance / distance_to_next)
			break
			
		path.remove(0)
		
		#Ends movement state
		if (path.size() == 0):
			if (will_interact):
				changeState(INTERACT)
			else:
				changeState(IDLE)
		



func changeState(newState):
	state = newState
	match state:
		IDLE:
			pass
		MOVE:
			pass
		INTERACT:
			pass
		
	

func _input(event):
	if !Input.is_action_pressed("ui_leftMouseClick"):
		return
	#Creates a nav2D path between player current position and mouse position on click
	var new_path = nav2D.get_simple_path(self.get_global_position(), get_global_mouse_position())
	
	#sets path for player node
	path = new_path
	
	will_interact = false
	
	#Triggers player Move state
	changeState(MOVE)


func _on_interactableObjects_input_event(viewport, event, shape_idx):
	if !Input.is_action_pressed("ui_leftMouseClick"):
		return
	
	will_interact = true
	interactable = interactableObjects.get_child(shape_idx)
	print("BANG!")
