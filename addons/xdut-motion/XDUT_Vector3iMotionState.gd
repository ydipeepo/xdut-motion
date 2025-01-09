class_name XDUT_Vector3iMotionState extends XDUT_Vector3MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_position() -> Variant:
	return Vector3i(super().round())

func get_initial_position() -> Variant:
	return Vector3i(super().round())

func get_final_position() -> Variant:
	return Vector3i(super().round())
