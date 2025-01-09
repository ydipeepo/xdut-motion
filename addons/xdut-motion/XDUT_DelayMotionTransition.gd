class_name XDUT_DelayMotionTransition extends XDUT_MotionTransition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_process() -> int:
	if not _delay_at_end:
		if _trans1 != null:
			return _trans1.get_process()
	return _trans2.get_process()

func next(
	state: XDUT_MotionState,
	delta_ticks: int,
	total_ticks: int) -> XDUT_MotionTransition:

	if _delay_at_end:
		delta_ticks = total_ticks - _trans2_base_ticks
		return _trans2.next(
			state,
			delta_ticks,
			total_ticks)

	_delay_reminder_ticks -= delta_ticks
	if _delay_reminder_ticks <= 0:
		_trans2_base_ticks = total_ticks - _delay_reminder_ticks
		delta_ticks += _delay_reminder_ticks
		total_ticks += _delay_reminder_ticks
		_delay_reminder_ticks = 0
		_delay_at_end = true
	if _trans1 != null:
		_trans1 = _trans1.next(
			state,
			delta_ticks,
			total_ticks)
	return self

#-------------------------------------------------------------------------------

var _trans1: XDUT_MotionTransition
var _trans2: XDUT_MotionTransition
var _trans2_base_ticks: int
var _delay_reminder_ticks: int
var _delay_at_end: bool

func _init(
	trans1: XDUT_MotionTransition,
	trans2: XDUT_MotionTransition,
	delay: float) -> void:

	assert(0.0 < delay)
	assert(trans2 != null)

	_trans1 = trans1
	_trans2 = trans2
	_delay_reminder_ticks = roundi(delay * 1000.0)
	_delay_at_end = false
