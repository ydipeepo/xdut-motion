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

class_name XDUT_CancelMotionTransition extends XDUT_MotionTransition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_process() -> int:
	return _process

func next(
	state: XDUT_MotionState,
	delta_ticks: int,
	total_ticks: int) -> XDUT_MotionTransition:

	if _first_call:
		state.set_initial_position(_initial_position)
		state.set_final_position(_final_position)
		state.set_initial_velocity(_initial_velocity)
		_first_call = false

	for k: int in state.get_element_count() * state.get_element_size():
		var fp := state.get_final_position_at(k)
		state.set_position_at(k, fp)
		state.set_velocity_at(k, 0.0)
		state.set_rest_at(k, true)
	return null

#-------------------------------------------------------------------------------

var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _process: int
var _first_call: bool

func _init(
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	process: int) -> void:

	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_process = process
	_first_call = true
