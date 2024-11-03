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

class_name XDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_element_count() -> int:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return 0

func get_element_size() -> int:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return 0

func set_position(value: Variant) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func set_position_at(index: int, value: float) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func get_position() -> Variant:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return null

func get_position_at(index: int) -> float:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return 0.0

func set_initial_position(value: Variant) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func set_initial_position_at(index: int, value: float) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func get_initial_position_at(index: int) -> float:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return 0.0

func set_final_position(value: Variant) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func set_final_position_at(index: int, value: float) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func get_final_position_at(index: int) -> float:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return 0.0

func set_velocity_at(index: int, value: float) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func get_velocity_at(index: int) -> float:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return 0.0

func set_initial_velocity(value: Variant) -> void:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)

func set_initial_velocity_at(index: int, value: float) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func get_initial_velocity_at(index: int) -> float:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return 0.0

func set_rest_at(index: int, value: bool) -> void:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)

func get_rest_at(index: int) -> bool:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return false

func can_set_initial_position(value: Variant) -> bool:
	#
	# 継承先で実装する必要があります。
	#

	return false

func can_set_final_position(value: Variant) -> bool:
	#
	# 継承先で実装する必要があります。
	#

	return false

func can_set_initial_velocity(value: Variant) -> bool:
	#
	# 継承先で実装する必要があります。
	#

	return false
