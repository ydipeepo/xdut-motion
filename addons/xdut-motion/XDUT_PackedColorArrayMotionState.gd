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
		TYPE_ARRAY:
			if can_set_initial_position(value):
				var read := 0
				for index: int in _element_count:
					match typeof(value[read]):
						TYPE_INT, \
						TYPE_FLOAT:
							_initial_position[index] = Color(
								_normalize_component(value[read + 0]),
								_normalize_component(value[read + 1]),
								_normalize_component(value[read + 2]),
								_normalize_component(value[read + 3]))
							read += 4
						TYPE_VECTOR3:
							var vector: Vector3 = value[read]
							_initial_position[index] = Color(
								vector.x,
								vector.y,
								vector.z)
							read += 1
						TYPE_VECTOR3I:
							var vector: Vector3i = value[read]
							_initial_position[index] = Color(
								vector.x / 255.0,
								vector.y / 255.0,
								vector.z / 255.0)
							read += 1
						TYPE_VECTOR4:
							var vector: Vector4 = value[read]
							_initial_position[index] = Color(
								vector.x,
								vector.y,
								vector.z,
								vector.w)
						TYPE_VECTOR4I:
							var vector: Vector4i = value[read]
							_initial_position[index] = Color(
								vector.x / 255.0,
								vector.y / 255.0,
								vector.z / 255.0,
								vector.w / 255.0)
							read += 1
						TYPE_COLOR:
							_initial_position[index] = value[read]
							read += 1
		TYPE_PACKED_COLOR_ARRAY:
			if can_set_initial_position(value):
				for index: int in _element_count:
					_initial_position[index] = value[index]
		TYPE_PACKED_VECTOR3_ARRAY:
			if can_set_initial_position(value):
				for index: int in _element_count:
					var vector: Vector3 = value[index]
					_initial_position[index] = Color(
						vector.x,
						vector.y,
						vector.z)
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
		TYPE_ARRAY:
			if can_set_final_position(value):
				var read := 0
				for index: int in _element_count:
					match typeof(value[read]):
						TYPE_INT, \
						TYPE_FLOAT:
							_final_position[index] = Color(
								_normalize_component(value[read + 0]),
								_normalize_component(value[read + 1]),
								_normalize_component(value[read + 2]),
								_normalize_component(value[read + 3]))
							read += 4
						TYPE_VECTOR3:
							var vector: Vector3 = value[read]
							_final_position[index] = Color(
								vector.x,
								vector.y,
								vector.z)
							read += 1
						TYPE_VECTOR3I:
							var vector: Vector3i = value[read]
							_final_position[index] = Color(
								vector.x / 255.0,
								vector.y / 255.0,
								vector.z / 255.0)
							read += 1
						TYPE_VECTOR4:
							var vector: Vector4 = value[read]
							_final_position[index] = Color(
								vector.x,
								vector.y,
								vector.z,
								vector.w)
							read += 1
						TYPE_VECTOR4I:
							var vector: Vector4i = value[read]
							_final_position[index] = Color(
								vector.x / 255.0,
								vector.y / 255.0,
								vector.z / 255.0,
								vector.w / 255.0)
							read += 1
						TYPE_COLOR:
							_final_position[index] = value[read]
							read += 1
		TYPE_PACKED_COLOR_ARRAY:
			if can_set_final_position(value):
				for index: int in _element_count:
					_final_position[index] = value[index]
		TYPE_PACKED_VECTOR3_ARRAY:
			if can_set_final_position(value):
				for index: int in _element_count:
					var vector: Vector3 = value[index]
					_final_position[index] = Color(
						vector.x,
						vector.y,
						vector.z)
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
		TYPE_ARRAY:
			if can_set_initial_velocity(value):
				var write := 0
				for index: int in value.size():
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							_initial_velocity[write] = _normalize_component(value[index])
							write += 1
						TYPE_VECTOR3:
							var vector: Vector3 = value[index]
							_initial_velocity[write + 0] = vector.x
							_initial_velocity[write + 1] = vector.y
							_initial_velocity[write + 2] = vector.z
							_initial_velocity[write + 3] = 1.0
							write += 4
						TYPE_VECTOR3I:
							var vector: Vector3i = value[index]
							_initial_velocity[write + 0] = vector.x / 255.0
							_initial_velocity[write + 1] = vector.y / 255.0
							_initial_velocity[write + 2] = vector.z / 255.0
							_initial_velocity[write + 3] = 1.0
							write += 4
						TYPE_VECTOR4:
							var vector: Vector4 = value[index]
							_initial_velocity[write + 0] = vector.x
							_initial_velocity[write + 1] = vector.y
							_initial_velocity[write + 2] = vector.z
							_initial_velocity[write + 3] = vector.w
							write += 4
						TYPE_VECTOR4I:
							var vector: Vector4i = value[index]
							_initial_velocity[write + 0] = vector.x / 255.0
							_initial_velocity[write + 1] = vector.y / 255.0
							_initial_velocity[write + 2] = vector.z / 255.0
							_initial_velocity[write + 3] = vector.w / 255.0
							write += 4
						TYPE_COLOR:
							var vector: Color = value[index]
							_initial_velocity[write + 0] = vector.r
							_initial_velocity[write + 1] = vector.g
							_initial_velocity[write + 2] = vector.b
							_initial_velocity[write + 3] = vector.a
							write += 4
		TYPE_PACKED_COLOR_ARRAY:
			if can_set_initial_velocity(value):
				for index: int in _element_count:
					_initial_velocity[index] = value[index]
		TYPE_PACKED_VECTOR3_ARRAY:
			if can_set_initial_velocity(value):
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
		TYPE_ARRAY:
			if _element_count <= value.size():
				var valid := true
				var count := 0
				for index: int in value.size():
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							count += 1
						TYPE_VECTOR3, \
						TYPE_VECTOR3I, \
						TYPE_VECTOR4, \
						TYPE_VECTOR4I, \
						TYPE_COLOR:
							if count % 4 != 0:
								valid = false
								break
							count += 4
						_:
							valid = false
							break
				if valid and count / 4 == _element_count:
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
		TYPE_ARRAY:
			if _element_count <= value.size():
				var valid := true
				var count := 0
				for index: int in value.size():
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							count += 1
						TYPE_VECTOR3, \
						TYPE_VECTOR3I, \
						TYPE_VECTOR4, \
						TYPE_VECTOR4I, \
						TYPE_COLOR:
							if count % 4 != 0:
								valid = false
								break
							count += 4
						_:
							valid = false
							break
				if valid and count / 4 == _element_count:
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
		TYPE_ARRAY:
			if _element_count <= value.size():
				var valid := true
				var count := 0
				for index: int in value.size():
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							count += 1
						TYPE_VECTOR3, \
						TYPE_VECTOR3I, \
						TYPE_VECTOR4, \
						TYPE_VECTOR4I, \
						TYPE_COLOR:
							if count % 4 != 0:
								valid = false
								break
							count += 4
						_:
							valid = false
							break
				if valid and count / 4 == _element_count:
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

static func _normalize_component(value: Variant) -> float:
	if typeof(value) == TYPE_INT:
		value = value / 255.0
	assert(typeof(value) == TYPE_FLOAT)
	return value

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
