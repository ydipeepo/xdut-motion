class_name XDUT_PackedFloat32ArrayMotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return _element_count

func get_element_size() -> int:
	return 1

func set_position(value: Variant) -> void:
	assert(
		value is PackedFloat32Array or
		value is PackedFloat64Array or
		value is PackedInt32Array or
		value is PackedInt64Array)
	assert(value.size() == _element_count)
	for index: int in _element_count:
		_position[index] = value[index]

func set_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count)
	_position[index] = value

func get_position() -> Variant:
	return _position

func get_position_at(index: int) -> float:
	assert(0 <= index and index < _element_count)
	return _position[index]

func set_initial_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			for index: int in _element_count:
				_initial_position[index] = _position[index]
		TYPE_ARRAY, \
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY, \
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY:
			if can_set_initial_position(value):
				for index: int in _element_count:
					_initial_position[index] = value[index]
		TYPE_CALLABLE:
			set_initial_position(value.call())

func set_initial_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count)
	_initial_position[index] = value

func get_initial_position() -> Variant:
	return _initial_position

func get_initial_position_at(index: int) -> float:
	assert(0 <= index and index < _element_count)
	return _initial_position[index]

func set_final_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			for index: int in _element_count:
				_final_position[index] = _position[index]
		TYPE_ARRAY, \
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY, \
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY:
			if can_set_final_position(value):
				for index: int in _element_count:
					_final_position[index] = value[index]
		TYPE_CALLABLE:
			set_final_position(value.call())

func set_final_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count)
	_final_position[index] = value

func get_final_position() -> Variant:
	return _final_position

func get_final_position_at(index: int) -> float:
	assert(0 <= index and index < _element_count)
	return _final_position[index]

func set_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count)
	_velocity[index] = value

func get_velocity_at(index: int) -> float:
	assert(0 <= index and index < _element_count)
	return _velocity[index]

func set_initial_velocity(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			for index: int in _element_count:
				_initial_velocity[index] = 0.0 if _rest[index] else _velocity[index]
		TYPE_ARRAY, \
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY, \
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY:
			if can_set_initial_velocity(value):
				_initial_velocity.assign(value)
		TYPE_CALLABLE:
			set_initial_velocity(value.call())

func set_initial_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count)
	_initial_velocity[index] = value

func get_initial_velocity_at(index: int) -> float:
	assert(0 <= index and index < _element_count)
	return _initial_velocity[index]

func set_rest_at(index: int, value: bool) -> void:
	assert(0 <= index and index < _element_count)
	_rest[index] = value

func get_rest_at(index: int) -> bool:
	assert(0 <= index and index < _element_count)
	return _rest[index]

func can_set_initial_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL:
			return true
		TYPE_ARRAY:
			if value.size() == _element_count:
				var valid := true
				for index: int in _element_count:
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							pass
						_:
							valid = false
							break
				if valid:
					return true
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY, \
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY:
			if value.size() == _element_count:
				return true
		TYPE_CALLABLE:
			if can_set_initial_position(value.call()):
				return true
	return false

func can_set_final_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL:
			return true
		TYPE_ARRAY:
			if value.size() == _element_count:
				var valid := true
				for index: int in _element_count:
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							pass
						_:
							valid = false
							break
				if valid:
					return true
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY, \
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY:
			if value.size() == _element_count:
				return true
		TYPE_CALLABLE:
			if can_set_final_position(value.call()):
				return true
	return false

func can_set_initial_velocity(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL:
			return true
		TYPE_ARRAY:
			if value.size() == _element_count:
				var valid := true
				for index: int in _element_count:
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							pass
						_:
							valid = false
							break
				if valid:
					return true
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY, \
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY:
			if value.size() == _element_count:
				return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: PackedFloat32Array
var _initial_position: PackedFloat32Array
var _final_position: PackedFloat32Array
var _velocity: Array[float]
var _initial_velocity: Array[float]
var _rest: Array[bool]
var _element_count: int

func _init(element_count: int) -> void:
	assert(0 <= element_count)
	_element_count = element_count
	_position.resize(_element_count)
	_initial_position.resize(_element_count)
	_final_position.resize(_element_count)
	_velocity.resize(_element_count)
	_initial_velocity.resize(_element_count)
	_rest.resize(_element_count)
	_rest.fill(true)
