class_name XDUT_Vector2MotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return 1

func get_element_size() -> int:
	return 2

func set_position(value: Variant) -> void:
	assert(
		value is Vector2 or
		value is Vector2i)
	_position = value

func set_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < 2)
	_position[index] = value

func get_position() -> Variant:
	return _position

func get_position_at(index: int) -> float:
	assert(0 <= index and index < 2)
	return _position[index]

func set_initial_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_position = _position
		TYPE_INT, \
		TYPE_FLOAT:
			_initial_position = Vector2(value, value)
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			_initial_position = value
		TYPE_CALLABLE:
			set_initial_position(value.call())

func set_initial_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < 2)
	_initial_position[index] = value

func get_initial_position() -> Variant:
	return _initial_position

func get_initial_position_at(index: int) -> float:
	assert(0 <= index and index < 2)
	return _initial_position[index]

func set_final_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_final_position = _position
		TYPE_INT, \
		TYPE_FLOAT:
			_final_position = Vector2(value, value)
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			_final_position = value
		TYPE_CALLABLE:
			set_final_position(value.call())

func set_final_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < 2)
	_final_position[index] = value

func get_final_position() -> Variant:
	return _final_position

func get_final_position_at(index: int) -> float:
	assert(0 <= index and index < 2)
	return _final_position[index]

func set_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 2)
	_velocity[index] = value

func get_velocity_at(index: int) -> float:
	assert(0 <= index and index < 2)
	return _velocity[index]

func set_initial_velocity(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_velocity[0] = 0.0 if _rest[0] else _velocity[0]
			_initial_velocity[1] = 0.0 if _rest[1] else _velocity[1]
		TYPE_INT, \
		TYPE_FLOAT:
			_initial_velocity.fill(value)
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			_initial_velocity[0] = value.x
			_initial_velocity[1] = value.y
		TYPE_CALLABLE:
			set_initial_velocity(value.call())

func set_initial_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 2)
	_initial_velocity[index] = value

func get_initial_velocity_at(index: int) -> float:
	assert(0 <= index and index < 2)
	return _initial_velocity[index]

func set_rest_at(index: int, value: bool) -> void:
	assert(0 <= index and index < 2)
	_rest[index] = value

func get_rest_at(index: int) -> bool:
	assert(0 <= index and index < 2)
	return _rest[index]

func can_set_initial_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_INT, \
		TYPE_FLOAT, \
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
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
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
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
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: Vector2
var _initial_position: Vector2
var _final_position: Vector2
var _velocity: Array[float] = [0.0, 0.0]
var _initial_velocity: Array[float] = [0.0, 0.0]
var _rest: Array[bool] = [true, true]
