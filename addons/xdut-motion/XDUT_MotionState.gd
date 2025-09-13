@abstract
class_name XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_element_count() -> int

@abstract
func get_element_size() -> int

@abstract
func set_position(value: Variant) -> void

@abstract
func set_position_at(index: int, value: float) -> void

@abstract
func get_position() -> Variant

@abstract
func get_position_at(index: int) -> float

@abstract
func set_initial_position(value: Variant) -> void

@abstract
func set_initial_position_at(index: int, value: float) -> void

@abstract
func get_initial_position_at(index: int) -> float

@abstract
func set_final_position(value: Variant) -> void

@abstract
func set_final_position_at(index: int, value: float) -> void

@abstract
func get_final_position_at(index: int) -> float

@abstract
func set_velocity_at(index: int, value: float) -> void

@abstract
func get_velocity_at(index: int) -> float

@abstract
func set_initial_velocity(value: Variant) -> void

@abstract
func set_initial_velocity_at(index: int, value: float) -> void

@abstract
func get_initial_velocity_at(index: int) -> float

@abstract
func set_rest_at(index: int, value: bool) -> void

@abstract
func get_rest_at(index: int) -> bool

@abstract
func can_set_initial_position(value: Variant) -> bool

@abstract
func can_set_final_position(value: Variant) -> bool

@abstract
func can_set_initial_velocity(value: Variant) -> bool
