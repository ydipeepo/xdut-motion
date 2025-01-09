class_name XDUT_SpringMotionTransition extends XDUT_MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_STIFFNESS := 100.0
const DEFAULT_DAMPING := 10.0
const DEFAULT_MASS := 1.0
const DEFAULT_REST_DELTA := 0.01
const DEFAULT_REST_SPEED := 0.01
const DEFAULT_LIMIT_OVERDAMPING := true
const DEFAULT_LIMIT_OVERSHOOTING := false

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

		var stride := state.get_element_size()
		for i: int in state.get_element_count():
			var offset := i * stride
			var delta_sq := 0.0
			var speed_sq := 0.0
			for j: int in stride:
				var k := offset + j
				var speed := state.get_initial_velocity_at(k)
				var delta_ := state.get_final_position_at(k) - state.get_initial_position_at(k)
				delta_sq += delta_ * delta_
				speed_sq += speed * speed
			if speed_sq <= _rest_speed_sq and delta_sq <= _rest_delta_sq:
				for j: int in state.get_element_size():
					var k := offset + j
					state.set_position_at(k, state.get_final_position_at(k))
					state.set_velocity_at(k, 0.0)
					state.set_rest_at(k, true)
			else:
				for j: int in state.get_element_size():
					var k := offset + j
					state.set_position_at(k, state.get_initial_position_at(k))
					state.set_velocity_at(k, state.get_initial_velocity_at(k))
					state.set_rest_at(k, false)
		_first_call = false
	#else:
	#	state.set_initial_position(_initial_position)
	#	state.set_final_position(_final_position)
	#	state.set_initial_velocity(_initial_velocity)

	#
	# Adam Miskiewicz 氏 (@skevy) による wobble でのオシレータ実装のポートです。
	#
	# //github.com/skevy/wobble/blob/develop/src/index.ts
	#

	_total_ticks += delta_ticks
	var total := _total_ticks / 1000.0

	var all_at_rest := true
	var omega2_total := min(_omega2 * total, _MAX_OMEGA2_TOTAL)
	var cos_omega1_total := cos(_omega1 * total)
	var sin_omega1_total := sin(_omega1 * total)
	var cosh_omega2_total := cosh(omega2_total)
	var sinh_omega2_total := sinh(omega2_total)
	var stride := state.get_element_size()
	for i: int in state.get_element_count():
		var offset := i * stride
		var at_rest := true
		var delta_sq := 0.0
		var speed_sq := 0.0
		for j: int in stride:
			var k := offset + j
			if not state.get_rest_at(k):
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := -state.get_initial_velocity_at(k)
				var x0 := p1 - p0
				var position: float
				var velocity: float
				if _zeta < 1.0:
					var u := v0 + _zeta * _omega0 * x0
					var e := exp(-_zeta * _omega0 * total)
					position = p1 - e * ((v0 + _zeta * _omega0 * x0) / _omega1 * sin_omega1_total + x0 * cos_omega1_total)
					velocity = _zeta * _omega0 * e * (sin_omega1_total * u / _omega1 + x0 * cos_omega1_total) - e * (cos_omega1_total * u - _omega1 * x0 * sin_omega1_total)
				elif _zeta == 1.0:
					var e := exp(-_omega0 * total)
					position = p1 - e * (x0 + (v0 + _omega0 * x0) * total)
					velocity = e * (v0 * (total * _omega0 - 1.0) + total * x0 * (_omega0 * _omega0))
				else:
					var u := v0 + _zeta * _omega0 * x0
					var e := exp(-_zeta * _omega0 * total)
					position = p1 - e * (u * sinh_omega2_total + _omega2 * x0 * cosh_omega2_total) / _omega2
					velocity = e * _zeta * _omega0 * (sinh_omega2_total * u + x0 * _omega2 * cosh_omega2_total) / _omega2 - e * (_omega2 * cosh_omega2_total * u + _omega2 * _omega2 * x0 * sinh_omega2_total) / _omega2
				if _limit_overshooting and (p1 < position if p0 < p1 else position < p1):
					state.set_rest_at(k, true)
					state.set_position_at(k, p1)
					state.set_velocity_at(k, 0.0)
				else:
					var delta_ := p1 - position
					delta_sq += delta_ * delta_
					speed_sq += velocity * velocity
					at_rest = false
					state.set_position_at(k, position)
					state.set_velocity_at(k, velocity)
		if not at_rest and speed_sq <= _rest_speed_sq and delta_sq <= _rest_delta_sq:
			for j: int in state.get_element_size():
				var k := offset + j
				if not state.get_rest_at(k):
					state.set_position_at(k, state.get_final_position_at(k))
					state.set_velocity_at(k, 0.0)
					state.set_rest_at(k, true)
		all_at_rest = at_rest and all_at_rest
	if not all_at_rest:
		return self

	return null

#-------------------------------------------------------------------------------

const _MAX_OMEGA2_TOTAL := 350.0

var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _process: int
var _first_call: bool
var _total_ticks: int

var _zeta: float
var _omega0: float
var _omega1: float
var _omega2: float
var _rest_delta_sq: float
var _rest_speed_sq: float
var _limit_overshooting: bool

func _init(
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	process: int,
	stiffness: float,
	damping: float,
	mass: float,
	rest_delta: float,
	rest_speed: float,
	limit_overdamping: bool,
	limit_overshooting: bool) -> void:

	assert(EPSILON <= stiffness)
	assert(0.0 <= damping)
	assert(EPSILON <= mass)
	assert(EPSILON <= rest_delta)
	assert(EPSILON <= rest_speed)

	var zeta := damping / (2.0 * sqrt(stiffness * mass))
	var zeta_sq := zeta * zeta
	var omega := sqrt(stiffness / mass)

	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_process = process
	_first_call = true
	_total_ticks = 0

	_zeta = minf(1.0, zeta) if limit_overdamping else zeta
	_omega0 = omega
	_omega1 = omega * sqrt(1.0 - zeta_sq)
	_omega2 = omega * sqrt(zeta_sq - 1.0)
	_rest_delta_sq = rest_delta * rest_delta
	_rest_speed_sq = rest_speed * rest_speed
	_limit_overshooting = limit_overshooting and stiffness != 0.0
