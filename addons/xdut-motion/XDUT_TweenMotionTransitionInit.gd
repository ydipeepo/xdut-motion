class_name XDUT_TweenMotionTransitionInit extends XDUT_MotionTransitionInit

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var duration := XDUT_TweenMotionTransition.DEFAULT_DURATION
var ease_type := XDUT_TweenMotionTransition.DEFAULT_EASE_TYPE
var trans_type := XDUT_TweenMotionTransition.DEFAULT_TRANS_TYPE

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func init(previous_trans: XDUT_MotionTransition) -> XDUT_MotionTransition:
	assert(0.0 <= duration)
	assert(0.0 <= delay)

	var trans: XDUT_MotionTransition = XDUT_TweenMotionTransition.new(
		initial_position,
		final_position,
		initial_velocity,
		process,
		duration,
		trans_type,
		ease_type)
	if 0.0 < delay:
		trans = XDUT_DelayMotionTransition.new(
			previous_trans,
			trans,
			delay)
	return trans
