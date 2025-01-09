class_name XDUT_Vector2iMotionState extends XDUT_Vector2MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_position() -> Variant:
	return Vector2i(super().round())

func get_initial_position() -> Variant:
	return Vector2i(super().round())

func get_final_position() -> Variant:
	return Vector2i(super().round())
