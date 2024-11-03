#-------------------------------------------------------------------------------
#
#
#	Copyright 2022-2024 Ydi (@ydipeepo.bsky.social)
#
#
#	Permission is hereby granted, free of charge, to any person obtaining
#	a copy of this software and associated documentation files (the "Software"),
#	to deal in the Software without restriction, including without limitation
#	the rights to use, copy, modify, merge, publish, distribute, sublicense,
#	and/or sell copies of the Software, and to permit persons to whom
#	the Software is furnished to do so, subject to the following conditions:
#
#	The above copyright notice and this permission notice shall be included in
#	all copies or substantial portions of the Software.
#
#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#	THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
#	ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#	OTHER DEALINGS IN THE SOFTWARE.
#
#
#-------------------------------------------------------------------------------

class_name XDUT_BasisMotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return 1

func get_element_size() -> int:
	return 12

func set_position(value: Variant) -> void:
	match typeof(value):
		TYPE_BASIS:
			_position = value
		TYPE_TRANSFORM3D:
			_position = value.basis
		_:
			assert(false)

func set_position_at(index: int, value: float) -> void:
	match index:
		0: _position.x.x = value
		1: _position.x.y = value
		2: _position.x.z = value
		3: _position.y.x = value
		4: _position.y.y = value
		5: _position.y.z = value
		6: _position.z.x = value
		7: _position.z.y = value
		8: _position.z.z = value
		_: assert(false)

func get_position() -> Variant:
	return _position

func get_position_at(index: int) -> float:
	var value: float
	match index:
		0: value = _position.x.x
		1: value = _position.x.y
		2: value = _position.x.z
		3: value = _position.y.x
		4: value = _position.y.y
		5: value = _position.y.z
		6: value = _position.z.x
		7: value = _position.z.y
		8: value = _position.z.z
		_: assert(false)
	return value

func set_initial_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_position = _position
		TYPE_BASIS:
			_initial_position = value
		TYPE_TRANSFORM3D:
			_initial_position = value.basis
		TYPE_CALLABLE:
			set_initial_position(value.call())

func set_initial_position_at(index: int, value: float) -> void:
	match index:
		0: _initial_position.x.x = value
		1: _initial_position.x.y = value
		2: _initial_position.x.z = value
		3: _initial_position.y.x = value
		4: _initial_position.y.y = value
		5: _initial_position.y.z = value
		6: _initial_position.z.x = value
		7: _initial_position.z.y = value
		8: _initial_position.z.z = value
		_: assert(false)

func get_initial_position() -> Variant:
	return _initial_position

func get_initial_position_at(index: int) -> float:
	var value: float
	match index:
		0: value = _initial_position.x.x
		1: value = _initial_position.x.y
		2: value = _initial_position.x.z
		3: value = _initial_position.y.x
		4: value = _initial_position.y.y
		5: value = _initial_position.y.z
		6: value = _initial_position.z.x
		7: value = _initial_position.z.y
		8: value = _initial_position.z.z
		_: assert(false)
	return value

func set_final_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_final_position = _position
		TYPE_BASIS:
			_final_position = value
		TYPE_TRANSFORM3D:
			_final_position = value.basis
		TYPE_CALLABLE:
			set_final_position(value.call())

func set_final_position_at(index: int, value: float) -> void:
	match index:
		0: _final_position.x.x = value
		1: _final_position.x.y = value
		2: _final_position.x.z = value
		3: _final_position.y.x = value
		4: _final_position.y.y = value
		5: _final_position.y.z = value
		6: _final_position.z.x = value
		7: _final_position.z.y = value
		8: _final_position.z.z = value
		_: assert(false)

func get_final_position() -> Variant:
	return _final_position

func get_final_position_at(index: int) -> float:
	var value: float
	match index:
		0: value = _final_position.x.x
		1: value = _final_position.x.y
		2: value = _final_position.x.z
		3: value = _final_position.y.x
		4: value = _final_position.y.y
		5: value = _final_position.y.z
		6: value = _final_position.z.x
		7: value = _final_position.z.y
		8: value = _final_position.z.z
		_: assert(false)
	return value

func set_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 9)
	_velocity[index] = value

func get_velocity_at(index: int) -> float:
	assert(0 <= index and index < 9)
	return _velocity[index]

func set_initial_velocity(value: Variant) -> void:
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
		TYPE_BASIS:
			_initial_velocity[0] = value.x.x
			_initial_velocity[1] = value.x.y
			_initial_velocity[2] = value.x.z
			_initial_velocity[3] = value.y.x
			_initial_velocity[4] = value.y.y
			_initial_velocity[5] = value.y.z
			_initial_velocity[6] = value.z.x
			_initial_velocity[7] = value.z.y
			_initial_velocity[8] = value.z.z
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
		TYPE_CALLABLE:
			set_initial_velocity(value.call())

func set_initial_velocity_at(index: int, value: float) -> void:
	assert(0 <= index and index < 9)
	_initial_velocity[index] = value

func get_initial_velocity_at(index: int) -> float:
	assert(0 <= index and index < 9)
	return _initial_velocity[index]

func set_rest_at(index: int, value: bool) -> void:
	assert(0 <= index and index < 9)
	_rest[index] = value

func get_rest_at(index: int) -> bool:
	assert(0 <= index and index < 9)
	return _rest[index]

func can_set_initial_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_BASIS, \
		TYPE_TRANSFORM3D:
			return true
		TYPE_CALLABLE:
			if can_set_initial_position(value.call()):
				return true
	return false

func can_set_final_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_BASIS, \
		TYPE_TRANSFORM3D:
			return true
		TYPE_CALLABLE:
			if can_set_final_position(value.call()):
				return true
	return false

func can_set_initial_velocity(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_BASIS, \
		TYPE_TRANSFORM3D:
			return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: Basis
var _initial_position: Basis
var _final_position: Basis
var _velocity: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
var _initial_velocity: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
var _rest: Array[bool] = [true, true, true, true, true, true, true, true, true]
