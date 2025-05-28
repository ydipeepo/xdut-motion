class_name XDUT_PackedColorArrayMotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return _element_count

func get_element_size() -> int:
	return 4

func set_position(value) -> void:
	match typeof(value):
		TYPE_PACKED_COLOR_ARRAY:
			assert(value.size() == _element_count)
			for index: int in _element_count:
				_position[index] = value[index]
		TYPE_PACKED_VECTOR3_ARRAY:
			assert(value.size() == _element_count)
			for index: int in _element_count:
				var vector: Vector3 = value[index]
				_position[index] = Color(vector.x, vector.y, vector.z)
		_:
			assert(false)

func set_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count * 4)
	_position[index / 4][index % 4] = value

func get_position() -> Variant:
	return _position

func get_position_at(index: int) -> float:
	assert(0 <= index and index < _element_count * 4)
	return _position[index / 4][index % 4]

func set_initial_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			for index: int in _element_count:
				_initial_position[index] = _position[index]
		TYPE_PACKED_COLOR_ARRAY:
			if value.size() == _element_count:
				for index: int in _element_count:
					_initial_position[index] = value[index]
		TYPE_PACKED_VECTOR3_ARRAY:
			if value.size() == _element_count:
				for index: int in _element_count:
					var vector: Vector3 = value[index]
					_initial_position[index] = Color(vector.x, vector.y, vector.z)
		TYPE_CALLABLE:
			set_initial_position(value.call())

func set_initial_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count * 4)
	_initial_position[index / 4][index % 4] = value

func get_initial_position() -> Variant:
	return _initial_position

func get_initial_position_at(index: int) -> float:
	assert(0 <= index and index < _element_count * 4)
	return _initial_position[index / 4][index % 4]

func set_final_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			for index: int in _element_count:
				_final_position[index] = _position[index]
		TYPE_PACKED_COLOR_ARRAY:
			if value.size() == _element_count:
				for index: int in _element_count:
					_final_position[index] = value[index]
		TYPE_PACKED_VECTOR3_ARRAY:
			if value.size() == _element_count:
				for index: int in _element_count:
					var vector: Vector3 = value[index]
					_final_position[index] = Color(vector.x, vector.y, vector.z)
		TYPE_CALLABLE:
			set_final_position(value.call())

func set_final_position_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count * 4)
	_final_position[index / 4][index % 4] = value

func get_final_position() -> Variant:
	return _final_position

func get_final_position_at(index: int) -> float:
	assert(0 <= index and index < _element_count * 4)
	return _final_position[index / 4][index % 4]

func set_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count * 4)
	_velocity[index] = value

func get_velocity_at(index: int) -> float:
	assert(0 <= index and index < _element_count * 4)
	return _velocity[index]

func set_initial_velocity(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			for index: int in _element_count * 4:
				_initial_velocity[index] = 0.0 if _rest[index] else _velocity[index]
		TYPE_PACKED_COLOR_ARRAY:
			if value.size() == _element_count:
				for index: int in _element_count:
					_initial_velocity[index] = value[index]
		TYPE_PACKED_VECTOR3_ARRAY:
			if value.size() == _element_count:
				for index: int in _element_count:
					var vector: Vector3 = value[index]
					_initial_velocity[index * 3 + 0] = vector.x
					_initial_velocity[index * 3 + 1] = vector.y
					_initial_velocity[index * 3 + 2] = vector.z
		TYPE_CALLABLE:
			set_initial_velocity(value.call())

func set_initial_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < _element_count * 4)
	_initial_velocity[index] = value

func get_initial_velocity_at(index: int) -> float:
	assert(0 <= index and index < _element_count * 4)
	return _initial_velocity[index]

func set_rest_at(index: int, value: bool) -> void:
	assert(0 <= index and index < _element_count * 4)
	_rest[index] = value

func get_rest_at(index: int) -> bool:
	assert(0 <= index and index < _element_count * 4)
	return _rest[index]

func can_set_initial_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL:
			return true
		TYPE_PACKED_COLOR_ARRAY:
			if value.size() == _element_count:
				return true
		TYPE_PACKED_VECTOR3_ARRAY:
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
		TYPE_PACKED_COLOR_ARRAY:
			if value.size() == _element_count:
				return true
		TYPE_PACKED_VECTOR3_ARRAY:
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
		TYPE_PACKED_COLOR_ARRAY:
			if value.size() == _element_count:
				return true
		TYPE_PACKED_VECTOR3_ARRAY:
			if value.size() == _element_count:
				return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: PackedColorArray
var _initial_position: PackedColorArray
var _final_position: PackedColorArray
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
	_velocity.resize(_element_count * 4)
	_initial_velocity.resize(_element_count * 4)
	_rest.resize(_element_count * 4)
	_rest.fill(true)
