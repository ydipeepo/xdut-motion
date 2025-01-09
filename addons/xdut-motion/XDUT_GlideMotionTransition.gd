class_name XDUT_GlideMotionTransition extends XDUT_MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

enum {
	PREFER_VELOCITY,
	PREFER_POSITION,
}

const DEFAULT_PREFER: int = XDUT_GlideMotionTransition.PREFER_VELOCITY
const DEFAULT_POWER := 0.8
const DEFAULT_TIME_CONSTANT := 0.35
const DEFAULT_REST_DELTA := 0.01

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_process() -> int:
	return _process

func next(
	state: XDUT_MotionState,
	delta_ticks: int,
	total_ticks: int) -> XDUT_MotionTransition:

	if _first_call:
		state.set_initial_position(_initial_position)
		state.set_final_position(_final_position)
		state.set_initial_velocity(_initial_velocity)
		match _prefer:
			PREFER_VELOCITY:
				_init_prefer_velocity(state)
			PREFER_POSITION:
				_init_prefer_position(state)
		_first_call = false
	#else:
	#	state.set_initial_position(_initial_position)
	#	state.set_final_position(_final_position)
	#	state.set_initial_velocity(_initial_velocity)

	_total_ticks += delta_ticks
	var total := _total_ticks / 1000.0

	var all_at_rest := true
	var exp_total := exp(-total / _time_constant)
	var stride := state.get_element_size()
	for i: int in state.get_element_count():
		var offset := i * stride
		var delta_sq := 0.0
		for j: int in stride:
			var k := offset + j
			var p0 := state.get_initial_position_at(k)
			var p1 := state.get_final_position_at(k)
			var x0 := p1 - p0
			var e := x0 * exp_total
			var p := p1 - e
			var v := e / _time_constant
			var d := p1 - p
			delta_sq += d * d
			state.set_position_at(k, p)
			state.set_velocity_at(k, v)
		if delta_sq <= _rest_delta_sq:
			for j: int in state.get_element_size():
				var k := offset + j
				state.set_position_at(k, state.get_final_position_at(k))
				state.set_velocity_at(k, 0.0)
				state.set_rest_at(k, true)
		else:
			all_at_rest = false
	if not all_at_rest:
		return self

	return null

#-------------------------------------------------------------------------------

var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _process: int
var _first_call: bool
var _total_ticks: int

var _prefer: int
var _power: float
var _time_constant: float
var _rest_delta_sq: float

func _init(
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	process: int,
	prefer: int,
	power: float,
	time_constant: float,
	rest_delta: float) -> void:

	assert(
		prefer == PREFER_VELOCITY or
		prefer == PREFER_POSITION)
	assert(EPSILON <= power)
	assert(0.0 <= time_constant)
	assert(EPSILON <= rest_delta)

	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_process = process
	_first_call = true
	_total_ticks = 0

	_prefer = prefer
	_power = power
	_time_constant = time_constant
	_rest_delta_sq = rest_delta * rest_delta

func _init_prefer_velocity(state: XDUT_MotionState) -> void:
	var stride := state.get_element_size()
	for i: int in state.get_element_count():
		var offset := i * stride
		var delta_sq := 0.0
		for j: int in stride:
			var k := offset + j
			var v0 := state.get_initial_velocity_at(k)
			var p0 := state.get_initial_position_at(k)
			var p1 := p0 + v0 * _power
			var x0 := p1 - p0
			state.set_final_position_at(k, p1)
			delta_sq += x0 * x0
		if delta_sq <= _rest_delta_sq:
			for j: int in state.get_element_size():
				var k := offset + j
				state.set_position_at(k, state.get_final_position_at(k))
				state.set_velocity_at(k, 0.0)
				state.set_rest_at(k, true)
		else:
			for j: int in state.get_element_size():
				var k := offset + j
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := (p1 - p0) / _time_constant
				state.set_position_at(k, p0)
				state.set_velocity_at(k, v0)
				state.set_rest_at(k, false)

func _init_prefer_position(state: XDUT_MotionState) -> void:
	var stride := state.get_element_size()
	for i: int in state.get_element_count():
		var offset := i * stride
		var delta_sq := 0.0
		for j: int in stride:
			var k := offset + j
			var p0 := state.get_initial_position_at(k)
			var p1 := state.get_final_position_at(k)
			var x0 := p1 - p0
			delta_sq += x0 * x0
		if delta_sq <= _rest_delta_sq:
			for j: int in state.get_element_size():
				var k := offset + j
				var p1 := state.get_final_position_at(k)
				state.set_position_at(k, p1)
				state.set_velocity_at(k, 0.0)
				state.set_rest_at(k, true)
		else:
			for j: int in state.get_element_size():
				var k := offset + j
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var x0 := p1 - p0
				state.set_position_at(k, p0)
				state.set_velocity_at(k, x0 / _time_constant)
				state.set_rest_at(k, false)
