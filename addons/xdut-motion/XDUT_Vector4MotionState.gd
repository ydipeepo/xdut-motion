class_name XDUT_Vector4MotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return 1

func get_element_size() -> int:
	return 4

func set_position(value: Variant) -> void:
	assert(
		value is Vector4 or
		value is Vector4i)
	_position = value

func set_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < 4)
	_position[index] = value

func get_position() -> Variant:
	return _position

func get_position_at(index: int) -> float:
	assert(0 <= index and index < 4)
	return _position[index]

func set_initial_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_position = _position
		TYPE_INT, \
		TYPE_FLOAT:
			_initial_position = Vector4(value, value, value, value)
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			_initial_position = value
		TYPE_CALLABLE:
			set_initial_position(value.call())

func set_initial_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < 4)
	_initial_position[index] = value

func get_initial_position() -> Variant:
	return _initial_position

func get_initial_position_at(index: int) -> float:
	assert(0 <= index and index < 4)
	return _initial_position[index]

func set_final_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_final_position = _position
		TYPE_INT, \
		TYPE_FLOAT:
			_final_position = Vector4(value, value, value, value)
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			_final_position = value
		TYPE_CALLABLE:
			set_final_position(value.call())

func set_final_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < 4)
	_final_position[index] = value

func get_final_position() -> Variant:
	return _final_position

func get_final_position_at(index: int) -> float:
	assert(0 <= index and index < 4)
	return _final_position[index]

func set_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 4)
	_velocity[index] = value

func get_velocity_at(index: int) -> float:
	assert(0 <= index and index < 4)
	return _velocity[index]

func set_initial_velocity(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_velocity[0] = 0.0 if _rest[0] else _velocity[0]
			_initial_velocity[1] = 0.0 if _rest[1] else _velocity[1]
			_initial_velocity[2] = 0.0 if _rest[2] else _velocity[2]
			_initial_velocity[3] = 0.0 if _rest[3] else _velocity[3]
		TYPE_INT, \
		TYPE_FLOAT:
			_initial_velocity.fill(value)
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			_initial_velocity[0] = value.x
			_initial_velocity[1] = value.y
			_initial_velocity[2] = value.z
			_initial_velocity[3] = value.w
		TYPE_CALLABLE:
			set_initial_velocity(value.call())

func set_initial_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 4)
	_initial_velocity[index] = value

func get_initial_velocity_at(index: int) -> float:
	assert(0 <= index and index < 4)
	return _initial_velocity[index]

func set_rest_at(index: int, value: bool) -> void:
	assert(0 <= index and index < 4)
	_rest[index] = value

func get_rest_at(index: int) -> bool:
	assert(0 <= index and index < 4)
	return _rest[index]

func can_set_initial_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_INT, \
		TYPE_FLOAT, \
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			return true
		TYPE_CALLABLE:
			if can_set_initial_position(value.call()):
				return true
	return false

func can_set_final_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_INT, \
		TYPE_FLOAT, \
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			return true
		TYPE_CALLABLE:
			if can_set_final_position(value.call()):
				return true
	return false

func can_set_initial_velocity(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_INT, \
		TYPE_FLOAT, \
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: Vector4
var _initial_position: Vector4
var _final_position: Vector4
var _velocity: Array[float] = [0.0, 0.0, 0.0, 0.0]
var _initial_velocity: Array[float] = [0.0, 0.0, 0.0, 0.0]
var _rest: Array[bool] = [true, true, true, true]
