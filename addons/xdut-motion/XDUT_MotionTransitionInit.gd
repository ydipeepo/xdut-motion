class_name XDUT_MotionTransitionInit

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var initial_position: Variant
var final_position: Variant
var initial_velocity: Variant
var process: int
var delay: float

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func init(previous_trans: XDUT_MotionTransition) -> XDUT_MotionTransition:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return null
