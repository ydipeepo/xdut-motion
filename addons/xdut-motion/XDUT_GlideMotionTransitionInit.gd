class_name XDUT_GlideMotionTransitionInit extends XDUT_MotionTransitionInit

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var prefer := XDUT_GlideMotionTransition.DEFAULT_PREFER
var power := XDUT_GlideMotionTransition.DEFAULT_POWER
var time_constant := XDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT
var rest_delta := XDUT_GlideMotionTransition.DEFAULT_REST_DELTA

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func init(previous_trans: XDUT_MotionTransition) -> XDUT_MotionTransition:
	assert(0.0 <= delay)

	var trans: XDUT_MotionTransition = XDUT_GlideMotionTransition.new(
		initial_position,
		final_position,
		initial_velocity,
		process,
		prefer,
		power,
		time_constant,
		rest_delta)
	if 0.0 < delay:
		trans = XDUT_DelayMotionTransition.new(
			previous_trans,
			trans,
			delay)
	return trans
