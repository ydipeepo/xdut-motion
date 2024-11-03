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

class_name XDUT_PackedInt64ArrayMotionState extends XDUT_PackedFloat64ArrayMotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_position() -> Variant:
	for index: int in get_element_count():
		_exotic_position[index] = int(get_position_at(index))
	return _exotic_position

func get_initial_position() -> Variant:
	for index: int in get_element_count():
		_exotic_initial_position[index] = int(get_position_at(index))
	return _exotic_initial_position

func get_final_position() -> Variant:
	for index: int in get_element_count():
		_exotic_final_position[index] = int(get_position_at(index))
	return _exotic_final_position

#-------------------------------------------------------------------------------

var _exotic_position: PackedInt64Array
var _exotic_initial_position: PackedInt64Array
var _exotic_final_position: PackedInt64Array

func _init(element_count: int) -> void:
	super(element_count)
	_exotic_position.resize(get_element_count())
	_exotic_initial_position.resize(get_element_count())
	_exotic_final_position.resize(get_element_count())
