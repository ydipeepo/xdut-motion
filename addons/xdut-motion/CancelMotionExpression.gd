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

class_name CancelMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## プリセットを読み込みます。
func preset(value: String) -> CancelMotionExpression:
	_set_preset.call(value, _trans_init)
	return self

## 開始までの遅延を設定します。
func delay(value: float) -> CancelMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.delay = value
	return self

## プロセスフレームで処理するよう設定します。
func process_default() -> CancelMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_DEFAULT
	return self

## 物理フレームで処理するよう設定します。
func process_physics() -> CancelMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_PHYSICS
	return self

## 最終位置を設定します。
func at(value: Variant) -> CancelMotionExpression:
	_trans_init.final_position = value
	return self

#-------------------------------------------------------------------------------

var _trans_init: XDUT_CancelMotionTransitionInit
var _set_preset: Callable

func _init(
	completion: XDUT_MotionCompletion,
	trans_init: XDUT_CancelMotionTransitionInit,
	set_preset: Callable) -> void:

	super(completion)

	assert(trans_init != null)
	_trans_init = trans_init
	_set_preset = set_preset
