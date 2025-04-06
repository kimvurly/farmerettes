class_name NodeStateMachine
extends Node

@export var initial_node_state : NodeState

var node_states : Dictionary = {} # dictionary of all the diff states
var current_node_state : NodeState
var current_node_state_name : String

func _ready() -> void:
	for child in get_children(): # adds all the existing states to the dictionary
		if child is NodeState:
			node_states[child.name.to_lower()] = child 
			child.transition.connect(transition_to) # calls the transition function to change to a diff state
	
	if initial_node_state:
		initial_node_state._on_enter()
		current_node_state = initial_node_state


func _process(delta : float) -> void:
	if current_node_state:
		current_node_state._on_process(delta)


func _physics_process(delta: float) -> void:
	if current_node_state:
		current_node_state._on_physics_process(delta)
		current_node_state._on_next_transitions()
		print("Current State: ", current_node_state_name)

 
func transition_to(node_state_name : String) -> void: # function for changing node states
	if node_state_name == current_node_state.name.to_lower(): # checks if current state is the same as the state called
		return
	
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	if !new_node_state: # checks if node state exists in the dictionary
		return
	
	if current_node_state: # exit the current state
		current_node_state._on_exit()
	
	new_node_state._on_enter() # transition into/enter the new state
	
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
	print("Current State: ", current_node_state_name)
