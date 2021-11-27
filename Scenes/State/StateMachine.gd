extends Node

var states = {}
var current_state
var controller 
var body

func _ready():
    current_state = null
    
func update(delta):
    if !current_state:
        return
    states[current_state].update(delta)

func change_state(next_state):
    if !states.has(next_state):
        print(next_state + " is not a valid state!")
        return
    if current_state:
        states[current_state].state_exit()
    current_state = next_state
    states[current_state].state_enter()

func add_state(stateName, state):
    state.controller = controller
    state.body = body
    states[stateName] = state;
    state.connect("change_state",self,"change_state")
func get_current_state():
    return states[current_state]
