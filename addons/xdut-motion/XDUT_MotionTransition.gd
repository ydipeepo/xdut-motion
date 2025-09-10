@abstract
class_name XDUT_MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const EPSILON := 0.00001

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_process() -> int

@abstract
func next(
	state: XDUT_MotionState,
	delta_ticks: int,
	total_ticks: int) -> XDUT_MotionTransition
