class_name XDUT_Transform3DMotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return 1

func get_element_size() -> int:
	return 12

func set_position(value: Variant) -> void:
	assert(value is Transform3D)
	_position = value

func set_position_at(index: int, value: float) -> void:
	match index:
		0:  _position.basis.x.x = value
		1:  _position.basis.x.y = value
		2:  _position.basis.x.z = value
		3:  _position.basis.y.x = value
		4:  _position.basis.y.y = value
		5:  _position.basis.y.z = value
		6:  _position.basis.z.x = value
		7:  _position.basis.z.y = value
		8:  _position.basis.z.z = value
		9:  _position.origin.x = value
		10: _position.origin.y = value
		11: _position.origin.z = value
		_:  assert(false)

func get_position() -> Variant:
	return _position

func get_position_at(index: int) -> float:
	var value: float
	match index:
		0:  value = _position.basis.x.x
		1:  value = _position.basis.x.y
		2:  value = _position.basis.x.z
		3:  value = _position.basis.y.x
		4:  value = _position.basis.y.y
		5:  value = _position.basis.y.z
		6:  value = _position.basis.z.x
		7:  value = _position.basis.z.y
		8:  value = _position.basis.z.z
		9:  value = _position.origin.x
		10: value = _position.origin.y
		11: value = _position.origin.z
		_:  assert(false)
	return value

func set_initial_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_position = _position
		TYPE_TRANSFORM3D:
			_initial_position = value
		TYPE_CALLABLE:
			set_initial_position(value.call())

func set_initial_position_at(index: int, value: float) -> void:
	match index:
		0:  _initial_position.basis.x.x = value
		1:  _initial_position.basis.x.y = value
		2:  _initial_position.basis.x.z = value
		3:  _initial_position.basis.y.x = value
		4:  _initial_position.basis.y.y = value
		5:  _initial_position.basis.y.z = value
		6:  _initial_position.basis.z.x = value
		7:  _initial_position.basis.z.y = value
		8:  _initial_position.basis.z.z = value
		9:  _initial_position.origin.x = value
		10: _initial_position.origin.y = value
		11: _initial_position.origin.z = value
		_:  assert(false)

func get_initial_position() -> Variant:
	return _initial_position

func get_initial_position_at(index: int) -> float:
	var value: float
	match index:
		0:  value = _initial_position.basis.x.x
		1:  value = _initial_position.basis.x.y
		2:  value = _initial_position.basis.x.z
		3:  value = _initial_position.basis.y.x
		4:  value = _initial_position.basis.y.y
		5:  value = _initial_position.basis.y.z
		6:  value = _initial_position.basis.z.x
		7:  value = _initial_position.basis.z.y
		8:  value = _initial_position.basis.z.z
		9:  value = _initial_position.origin.x
		10: value = _initial_position.origin.y
		11: value = _initial_position.origin.z
		_:  assert(false)
	return value

func set_final_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_final_position = _position
		TYPE_TRANSFORM3D:
			_final_position = value
		TYPE_CALLABLE:
			set_final_position(value.call())

func set_final_position_at(index: int, value: float) -> void:
	match index:
		0:  _final_position.basis.x.x = value
		1:  _final_position.basis.x.y = value
		2:  _final_position.basis.x.z = value
		3:  _final_position.basis.y.x = value
		4:  _final_position.basis.y.y = value
		5:  _final_position.basis.y.z = value
		6:  _final_position.basis.z.x = value
		7:  _final_position.basis.z.y = value
		8:  _final_position.basis.z.z = value
		9:  _final_position.origin.x = value
		10: _final_position.origin.y = value
		11: _final_position.origin.z = value
		_:  assert(false)

func get_final_position() -> Variant:
	return _final_position

func get_final_position_at(index: int) -> float:
	var value: float
	match index:
		0:  value = _final_position.basis.x.x
		1:  value = _final_position.basis.x.y
		2:  value = _final_position.basis.x.z
		3:  value = _final_position.basis.y.x
		4:  value = _final_position.basis.y.y
		5:  value = _final_position.basis.y.z
		6:  value = _final_position.basis.z.x
		7:  value = _final_position.basis.z.y
		8:  value = _final_position.basis.z.z
		9:  value = _final_position.origin.x
		10: value = _final_position.origin.y
		11: value = _final_position.origin.z
		_:  assert(false)
	return value

func set_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 12)
	_velocity[index] = value

func get_velocity_at(index: int) -> float:
	assert(0 <= index and index < 12)
	return _velocity[index]

func set_initial_velocity(value) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_velocity[0] = 0.0 if _rest[0] else _velocity[0]
			_initial_velocity[1] = 0.0 if _rest[1] else _velocity[1]
			_initial_velocity[2] = 0.0 if _rest[2] else _velocity[2]
			_initial_velocity[3] = 0.0 if _rest[3] else _velocity[3]
			_initial_velocity[4] = 0.0 if _rest[4] else _velocity[4]
			_initial_velocity[5] = 0.0 if _rest[5] else _velocity[5]
			_initial_velocity[6] = 0.0 if _rest[6] else _velocity[6]
			_initial_velocity[7] = 0.0 if _rest[7] else _velocity[7]
			_initial_velocity[8] = 0.0 if _rest[8] else _velocity[8]
			_initial_velocity[9] = 0.0 if _rest[9] else _velocity[9]
			_initial_velocity[10] = 0.0 if _rest[10] else _velocity[10]
			_initial_velocity[11] = 0.0 if _rest[11] else _velocity[11]
		TYPE_TRANSFORM3D:
			_initial_velocity[0] = value.basis.x.x
			_initial_velocity[1] = value.basis.x.y
			_initial_velocity[2] = value.basis.x.z
			_initial_velocity[3] = value.basis.y.x
			_initial_velocity[4] = value.basis.y.y
			_initial_velocity[5] = value.basis.y.z
			_initial_velocity[6] = value.basis.z.x
			_initial_velocity[7] = value.basis.z.y
			_initial_velocity[8] = value.basis.z.z
			_initial_velocity[9] = value.origin.x
			_initial_velocity[10] = value.origin.y
			_initial_velocity[11] = value.origin.z
		TYPE_CALLABLE:
			set_initial_velocity(value.call())

func set_initial_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 12)
	_initial_velocity[index] = value

func get_initial_velocity_at(index: int) -> float:
	assert(0 <= index and index < 12)
	return _initial_velocity[index]

func set_rest_at(index: int, value: bool) -> void:
	assert(0 <= index and index < 12)
	_rest[index] = value

func get_rest_at(index: int) -> bool:
	assert(0 <= index and index < 12)
	return _rest[index]

func can_set_initial_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_TRANSFORM3D:
			return true
		TYPE_CALLABLE:
			if can_set_initial_position(value.call()):
				return true
	return false

func can_set_final_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_TRANSFORM3D:
			return true
		TYPE_CALLABLE:
			if can_set_final_position(value.call()):
				return true
	return false

func can_set_initial_velocity(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_TRANSFORM3D:
			return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: Transform3D
var _initial_position: Transform3D
var _final_position: Transform3D
var _velocity: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
var _initial_velocity: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
var _rest: Array[bool] = [true, true, true, true, true, true, true, true, true, true, true, true]
