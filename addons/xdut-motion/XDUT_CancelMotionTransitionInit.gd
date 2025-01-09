class_name XDUT_CancelMotionTransitionInit extends XDUT_MotionTransitionInit

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func init(previous_trans: XDUT_MotionTransition) -> XDUT_MotionTransition:
	assert(0.0 <= delay)

	var trans: XDUT_MotionTransition = XDUT_CancelMotionTransition.new(
		initial_position,
		final_position,
		initial_velocity,
		process)
	if 0.0 < delay:
		trans = XDUT_DelayMotionTransition.new(
			previous_trans,
			trans,
			delay)
	return trans
