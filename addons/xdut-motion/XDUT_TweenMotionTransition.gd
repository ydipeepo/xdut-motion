class_name XDUT_TweenMotionTransition extends XDUT_MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_DURATION := 1.0
const DEFAULT_EASE_TYPE: int = Tween.EASE_IN_OUT
const DEFAULT_TRANS_TYPE: int = Tween.TRANS_LINEAR

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

		for k: int in state.get_element_count() * state.get_element_size():
			state.set_position_at(k, state.get_initial_position_at(k))
			state.set_velocity_at(k, state.get_initial_velocity_at(k))
			state.set_rest_at(k, false)
		_first_call = false
	#else:
	#	state.set_initial_position(_initial_position)
	#	state.set_final_position(_final_position)
	#	state.set_initial_velocity(_initial_velocity)
	
	_total_ticks += delta_ticks
	var total := _total_ticks / 1000.0

	if total < _duration:
		_ease.call(state, total)
		return self

	for k: int in state.get_element_count() * state.get_element_size():
		var p1 := state.get_final_position_at(k)
		state.set_position_at(k, p1)
		state.set_velocity_at(k, 0.0)
		state.set_rest_at(k, true)
	return null

#-------------------------------------------------------------------------------

var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _process: int
var _first_call: bool
var _total_ticks: int

var _duration: float
var _ease: Callable
var _trans_f: Callable
var _trans_d: Callable

func _init(
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	process: int,
	duration: float,
	trans_type: int,
	ease_type: int) -> void:

	assert(0.0 <= duration)

	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_process = process
	_first_call = true
	_total_ticks = 0

	_duration = duration
	match ease_type:
		Tween.EASE_IN:
			_ease = _ease_in
		Tween.EASE_OUT:
			_ease = _ease_out
		Tween.EASE_IN_OUT:
			_ease = _ease_in_out
		Tween.EASE_OUT_IN:
			_ease = _ease_out_in
		_:
			assert(false)
	match trans_type:
		Tween.TRANS_LINEAR:
			_trans_d = _trans_linear_d
			_trans_f = _trans_linear_f
		Tween.TRANS_QUAD:
			_trans_d = _trans_quadratic_d
			_trans_f = _trans_quadratic_f
		Tween.TRANS_CUBIC:
			_trans_d = _trans_cubic_d
			_trans_f = _trans_cubic_f
		Tween.TRANS_QUART:
			_trans_d = _trans_quartic_d
			_trans_f = _trans_quartic_f
		Tween.TRANS_QUINT:
			_trans_d = _trans_quintic_d
			_trans_f = _trans_quintic_f
		Tween.TRANS_SINE:
			_trans_d = _trans_sinusoidal_d
			_trans_f = _trans_sinusoidal_f
		Tween.TRANS_EXPO:
			_trans_d = _trans_exponential_d
			_trans_f = _trans_exponential_f
		Tween.TRANS_CIRC:
			_trans_d = _trans_circular_d
			_trans_f = _trans_circular_f
		Tween.TRANS_ELASTIC:
			_trans_d = _trans_elastic_d
			_trans_f = _trans_elastic_f
		Tween.TRANS_BACK:
			_trans_d = _trans_back_d
			_trans_f = _trans_back_f
		Tween.TRANS_BOUNCE:
			_trans_d = _trans_bounce_d
			_trans_f = _trans_bounce_f
		_:
			assert(false)

func _ease_in(state: XDUT_MotionState, total: float) -> void:
	var x := total / _duration
	var x_D := 0.0
	var x_A := 1.0
	var d: float
	d = _trans_d.call(x)
	x = _trans_f.call(x)
	var p := x * x_A + x_D
	var v := d
	for k: int in state.get_element_count() * state.get_element_size():
		var p0 := state.get_initial_position_at(k)
		var p1 := state.get_final_position_at(k)
		var x0 := p1 - p0
		state.set_position_at(k, p0 + x0 * p)
		state.set_velocity_at(k, v * x0 / _duration)

func _ease_out(state: XDUT_MotionState, total: float) -> void:
	var x := total / _duration
	var x_D := 1.0
	var x_A := -1.0
	var d: float
	x = 1.0 - x
	d = _trans_d.call(x)
	x = _trans_f.call(x)
	var p := x * x_A + x_D
	var v := d
	for k: int in state.get_element_count() * state.get_element_size():
		var p0 := state.get_initial_position_at(k)
		var p1 := state.get_final_position_at(k)
		var x0 := p1 - p0
		state.set_position_at(k, p0 + x0 * p)
		state.set_velocity_at(k, v * x0 / _duration)

func _ease_in_out(state: XDUT_MotionState, total: float) -> void:
	var x := total / _duration
	var x_D: float
	var x_A: float
	var d: float
	if x < 0.5:
		x = x * 2.0
		x_D = 0.0
		x_A = 0.5
	else:
		x = 2.0 - x * 2.0
		x_D = 1.0
		x_A = -0.5
	d = _trans_d.call(x)
	x = _trans_f.call(x)
	var p := x * x_A + x_D
	var v := d
	for k: int in state.get_element_count() * state.get_element_size():
		var p0 := state.get_initial_position_at(k)
		var p1 := state.get_final_position_at(k)
		var x0 := p1 - p0
		state.set_position_at(k, p0 + x0 * p)
		state.set_velocity_at(k, v * x0 / _duration)

func _ease_out_in(state: XDUT_MotionState, total: float) -> void:
	var x := total / _duration
	var x_D: float
	var x_A: float
	var d: float
	if x < 0.5:
		x = 1.0 - x * 2.0
		x_D = 0.5
		x_A = -0.5
	else:
		x = x * 2.0 - 1.0
		x_D = 0.5
		x_A = 0.5
	d = _trans_d.call(x)
	x = _trans_f.call(x)
	var p := x * x_A + x_D
	var v := d
	for k: int in state.get_element_count() * state.get_element_size():
		var p0 := state.get_initial_position_at(k)
		var p1 := state.get_final_position_at(k)
		var x0 := p1 - p0
		state.set_position_at(k, p0 + x0 * p)
		state.set_velocity_at(k, v * x0 / _duration)

static func _trans_linear_f(x: float) -> float:
	return x

static func _trans_linear_d(x: float) -> float:
	return 1.0

static func _trans_quadratic_f(x: float) -> float:
	return x * x

static func _trans_quadratic_d(x: float) -> float:
	return 2.0 * x

static func _trans_cubic_f(x: float) -> float:
	return x * x * x

static func _trans_cubic_d(x: float) -> float:
	return 3.0 * x * x

static func _trans_quartic_f(x: float) -> float:
	return x * x * x * x

static func _trans_quartic_d(x: float) -> float:
	return 4.0 * x * x * x

static func _trans_quintic_f(x: float) -> float:
	return x * x * x * x * x

static func _trans_quintic_d(x: float) -> float:
	return 5.0 * x * x * x * x

static func _trans_sinusoidal_f(x: float) -> float:
	const HALF_PI := PI * 0.5
	return 1.0 - sin((1.0 - x) * HALF_PI)

static func _trans_sinusoidal_d(x: float) -> float:
	const HALF_PI := PI * 0.5
	return PI * cos((1.0 - x) * HALF_PI) * 0.5

static func _trans_exponential_f(x: float) -> float:
	return 0.0 if x == 0.0 else pow(1024.0, x - 1.0)

static func _trans_exponential_d(x: float) -> float:
	const L1024 := log(1024.0)
	return L1024 * pow(1024, x - 1.0)

static func _trans_circular_f(x: float) -> float:
	return 1.0 - sqrt(1.0 - x * x)

static func _trans_circular_d(x: float) -> float:
	return x / sqrt(1.0 - x * x)

static func _trans_elastic_f(x: float) -> float:
	if x == 0.0:
		return 0.0
	if x == 1.0:
		return 1.0
	const FIVE_PI := PI * 5.0
	return -pow(2.0, 10.0 * (x - 1.0)) * sin((x - 1.1) * FIVE_PI)

static func _trans_elastic_d(x: float) -> float:
	const FIVE_PI := PI * 5.0
	const L2 := log(2.0)
	var t := FIVE_PI * (x - 1.1)
	return -(10.0 * L2 * sin(t) + FIVE_PI * cos(t)) * pow(2.0, 10.0 * x - 10.0)

static func _trans_back_f(x: float) -> float:
	if x == 1.0:
		return 1.0
	const S := 1.70158
	const S_1 := S + 1.0
	return x * x * (S_1 * x - S)

static func _trans_back_d(x: float) -> float:
	const S := 1.70158
	const S_1 := S + 1.0
	return x * x * S_1 + 2.0 * x * (S_1 * x - S)

static func _trans_bounce_f_forward(x: float) -> float:
	if x < 1.0 / 2.75:
		return 7.5625 * x * x
	if x < 2.0 / 2.75:
		x -= 1.5 / 2.75
		return 7.5625 * x * x + 0.75
	if x < 2.5 / 2.75:
		x -= 2.25 / 2.75
		return 7.5625 * x * x + 0.9375
	x -= 2.625 / 2.75
	return 7.5625 * x * x + 0.984375

static func _trans_bounce_d_forward(x: float) -> float:
	if x < 1.0 / 2.75:
		return 15.125 * x
	if x < 2.0 / 2.75:
		return 15.125 * x - 8.25
	if x < 2.5 / 2.75:
		return 15.125 * x - 12.375
	return 15.125 * x - 14.4375

static func _trans_bounce_f(x: float) -> float:
	return 1.0 - _trans_bounce_f_forward(1.0 - x)

static func _trans_bounce_d(x: float) -> float:
	return _trans_bounce_d_forward(1.0 - x)
