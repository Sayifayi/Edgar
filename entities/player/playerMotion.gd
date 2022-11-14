extends KinematicBody2D

var path : PoolVector2Array

export var speed = 200

#Defines default state and possible player states
enum{IDLE, MOVE, INTERACT}
var state = IDLE


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
	
	#Iterates upon path created on player controller
	for i in range (path.size()):
		var distance_to_next = startingPoint.distance_to(path[0])
		 
		#Interpolates position coordinates between current and next point in path array
		if (move_distance <= distance_to_next):
			position  = startingPoint.linear_interpolate(path[0], move_distance / distance_to_next)
			break
		#Clears array
		path.remove(0)
		
		#Ends movement state
		if (path.size() == 0):
			changeState(IDLE)
			
			
func changeState(newState):
	state = newState
	match state:
		IDLE:
			pass
		MOVE:
			pass
	

