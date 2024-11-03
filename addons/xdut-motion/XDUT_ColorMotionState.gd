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

class_name XDUT_ColorMotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return 1

func get_element_size() -> int:
	return 4

func set_position(value: Variant) -> void:
	match typeof(value):
		TYPE_COLOR:
			_position = value
		TYPE_STRING:
			_position = Color(value)
		TYPE_VECTOR3:
			_position.r = value.x
			_position.g = value.y
			_position.b = value.z
			_position.a = 1.0
		TYPE_VECTOR3I:
			_position.r = value.x / 255.0
			_position.g = value.y / 255.0
			_position.b = value.z / 255.0
			_position.a = 1.0
		TYPE_VECTOR4:
			_position.r = value.x
			_position.g = value.y
			_position.b = value.z
			_position.a = value.w
		TYPE_VECTOR4I:
			_position.r = value.x / 255.0
			_position.g = value.y / 255.0
			_position.b = value.z / 255.0
			_position.a = value.w / 255.0
		_:
			assert(false)

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
		TYPE_COLOR:
			_initial_position = value
		TYPE_STRING:
			_initial_position = Color(value)
		TYPE_VECTOR3:
			_initial_position.r = value.x
			_initial_position.g = value.y
			_initial_position.b = value.z
			_initial_position.a = 1.0
		TYPE_VECTOR3I:
			_initial_position.r = value.x / 255.0
			_initial_position.g = value.y / 255.0
			_initial_position.b = value.z / 255.0
			_initial_position.a = 1.0
		TYPE_VECTOR4:
			_initial_position.r = value.x
			_initial_position.g = value.y
			_initial_position.b = value.z
			_initial_position.a = value.w
		TYPE_VECTOR4I:
			_initial_position.r = value.x / 255.0
			_initial_position.g = value.y / 255.0
			_initial_position.b = value.z / 255.0
			_initial_position.a = value.w / 255.0
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
		TYPE_COLOR:
			_final_position = value
		TYPE_STRING:
			_final_position = Color(value)
		TYPE_VECTOR3:
			_final_position.r = value.x
			_final_position.g = value.y
			_final_position.b = value.z
			_final_position.a = 1.0
		TYPE_VECTOR3I:
			_final_position.r = value.x / 255.0
			_final_position.g = value.y / 255.0
			_final_position.b = value.z / 255.0
			_final_position.a = 1.0
		TYPE_VECTOR4:
			_final_position.r = value.x
			_final_position.g = value.y
			_final_position.b = value.z
			_final_position.a = value.w
		TYPE_VECTOR4I:
			_final_position.r = value.x / 255.0
			_final_position.g = value.y / 255.0
			_final_position.b = value.z / 255.0
			_final_position.a = value.w / 255.0
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
		TYPE_COLOR:
			_initial_velocity[0] = value.r
			_initial_velocity[1] = value.g
			_initial_velocity[2] = value.b
			_initial_velocity[3] = value.a
		TYPE_VECTOR3:
			_initial_velocity[0] = value.x
			_initial_velocity[1] = value.y
			_initial_velocity[2] = value.z
			_initial_velocity[3] = 0.0
		TYPE_VECTOR3I:
			_initial_velocity[0] = value.x / 255.0
			_initial_velocity[1] = value.y / 255.0
			_initial_velocity[2] = value.z / 255.0
			_initial_velocity[3] = 0.0
		TYPE_VECTOR4:
			_initial_velocity[0] = value.x
			_initial_velocity[1] = value.y
			_initial_velocity[2] = value.z
			_initial_velocity[3] = value.w
		TYPE_VECTOR4I:
			_initial_velocity[0] = value.x / 255.0
			_initial_velocity[1] = value.y / 255.0
			_initial_velocity[2] = value.z / 255.0
			_initial_velocity[3] = value.w / 255.0
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
		TYPE_COLOR, \
		TYPE_STRING, \
		TYPE_VECTOR3, \
		TYPE_VECTOR3I, \
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
		TYPE_COLOR, \
		TYPE_STRING, \
		TYPE_VECTOR3, \
		TYPE_VECTOR3I, \
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
		TYPE_COLOR, \
		TYPE_VECTOR3, \
		TYPE_VECTOR3I, \
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: Color
var _initial_position: Color
var _final_position: Color
var _velocity: Array[float] = [0.0, 0.0, 0.0, 0.0]
var _initial_velocity: Array[float] = [0.0, 0.0, 0.0, 0.0]
var _rest: Array[bool] = [true, true, true, true]
