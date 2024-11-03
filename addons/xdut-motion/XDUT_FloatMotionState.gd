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

class_name XDUT_FloatMotionState extends XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	return 1

func get_element_size() -> int:
	return 1

func set_position(value: Variant) -> void:
	assert(
		value is float or
		value is int)
	_position = value

func set_position_at(index: int, value: float) -> void:
	assert(index == 0)
	_position = value

func get_position() -> Variant:
	return _position

func get_position_at(index: int) -> float:
	assert(index == 0)
	return _position

func set_initial_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_position = _position
		TYPE_FLOAT:
			_initial_position = value
		TYPE_INT:
			_initial_position = value
		TYPE_CALLABLE:
			set_initial_position(value.call())

func set_initial_position_at(index: int, value: float) -> void:
	assert(index == 0)
	_initial_position = value

func get_initial_position() -> Variant:
	return _initial_position

func get_initial_position_at(index: int) -> float:
	assert(index == 0)
	return _initial_position

func set_final_position(value: Variant) -> void:
	match typeof(value):
		TYPE_NIL:
			_final_position = _position
		TYPE_FLOAT:
			_final_position = value
		TYPE_INT:
			_final_position = value
		TYPE_CALLABLE:
			set_final_position(value.call())

func set_final_position_at(index: int, value: float) -> void:
	assert(index == 0)
	_final_position = value

func get_final_position() -> Variant:
	return _final_position

func get_final_position_at(index: int) -> float:
	assert(index == 0)
	return _final_position

func set_velocity_at(index: int, value: float) -> void:
	assert(index == 0)
	_velocity = value

func get_velocity_at(index: int) -> float:
	assert(index == 0)
	return _velocity

func set_initial_velocity(value) -> void:
	match typeof(value):
		TYPE_NIL:
			_initial_velocity = 0.0 if _rest else _velocity
		TYPE_FLOAT:
			_initial_velocity = value
		TYPE_INT:
			_initial_velocity = value
		TYPE_CALLABLE:
			set_initial_velocity(value.call())

func set_initial_velocity_at(index: int, value: float) -> void:
	assert(index == 0)
	_initial_velocity = value

func get_initial_velocity_at(index: int) -> float:
	assert(index == 0)
	return _initial_velocity

func set_rest_at(index: int, value: bool) -> void:
	assert(index == 0)
	_rest = value

func get_rest_at(index: int) -> bool:
	assert(index == 0)
	return _rest

func can_set_initial_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_FLOAT, \
		TYPE_INT:
			return true
		TYPE_CALLABLE:
			if can_set_initial_position(value.call()):
				return true
	return false

func can_set_final_position(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_FLOAT, \
		TYPE_INT:
			return true
		TYPE_CALLABLE:
			if can_set_final_position(value.call()):
				return true
	return false

func can_set_initial_velocity(value: Variant) -> bool:
	match typeof(value):
		TYPE_NIL, \
		TYPE_FLOAT, \
		TYPE_INT:
			return true
		TYPE_CALLABLE:
			if can_set_initial_velocity(value.call()):
				return true
	return false

#-------------------------------------------------------------------------------

var _position: float
var _initial_position: float
var _final_position: float
var _velocity: float
var _initial_velocity: float
var _rest := true
