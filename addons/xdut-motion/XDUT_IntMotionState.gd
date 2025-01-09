class_name XDUT_IntMotionState extends XDUT_FloatMotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_position() -> Variant:
	return roundi(super())

func get_initial_position() -> Variant:
	return roundi(super())

func get_final_position() -> Variant:
	return roundi(super())
