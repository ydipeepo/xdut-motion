class_name XDUT_Vector4iMotionState extends XDUT_Vector4MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_position() -> Variant:
	return Vector4i(super().round())

func get_initial_position() -> Variant:
	return Vector4i(super().round())

func get_final_position() -> Variant:
	return Vector4i(super().round())
