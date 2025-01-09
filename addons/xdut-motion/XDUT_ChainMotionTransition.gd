class_name XDUT_ChainMotionTransition extends XDUT_MotionTransition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_process() -> int:
	if _trans1 != null:
		return _trans1.get_process()
	return _trans2.get_process()

func next(
	state: XDUT_MotionState,
	delta_ticks: int,
	total_ticks: int) -> XDUT_MotionTransition:

	if _trans1 != null:
		_trans1 = _trans1.next(state, delta_ticks, total_ticks)
		return self
	return _trans2.next(state, delta_ticks, total_ticks)

#-------------------------------------------------------------------------------

var _trans1: XDUT_MotionTransition
var _trans2: XDUT_MotionTransition

func _init(
	trans1: XDUT_MotionTransition,
	trans2: XDUT_MotionTransition) -> void:

	assert(trans1 != null)
	assert(trans2 != null)

	_trans1 = trans1
	_trans2 = trans2
