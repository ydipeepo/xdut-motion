class_name XDUT_SpringMotionTransitionInit extends XDUT_MotionTransitionInit

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var stiffness := XDUT_SpringMotionTransition.DEFAULT_STIFFNESS
var damping := XDUT_SpringMotionTransition.DEFAULT_DAMPING
var mass := XDUT_SpringMotionTransition.DEFAULT_MASS
var rest_delta := XDUT_SpringMotionTransition.DEFAULT_REST_DELTA
var rest_speed := XDUT_SpringMotionTransition.DEFAULT_REST_SPEED
var limit_overdamping := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING
var limit_overshooting := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func init(previous_trans: XDUT_MotionTransition) -> XDUT_MotionTransition:
	assert(0.0 <= delay)

	var trans: XDUT_MotionTransition = XDUT_SpringMotionTransition.new(
		initial_position,
		final_position,
		initial_velocity,
		process,
		stiffness,
		damping,
		mass,
		rest_delta,
		rest_speed,
		limit_overdamping,
		limit_overshooting)
	if 0.0 < delay:
		trans = XDUT_DelayMotionTransition.new(
			previous_trans,
			trans,
			delay)
	return trans
