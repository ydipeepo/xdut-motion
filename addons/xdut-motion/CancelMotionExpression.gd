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

## キャンセルを構成するためのメソッドを含むクラスです。
class_name CancelMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## このキャンセルに対しプリセットを適用します。
func preset(value: String) -> CancelMotionExpression:
	_set_preset.call(value, _trans_init)
	return self

## このキャンセルを開始するまでの遅延を設定します。
func delay(value: float) -> CancelMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.delay = value
	return self

## このキャンセルを処理するフレームを設定します。
func set_process(value: int) -> CancelMotionExpression:
	match value:
		XDUT_MotionTimer.PROCESS_DEFAULT, \
		XDUT_MotionTimer.PROCESS_PHYSICS:
			_trans_init.process = value
	return self

## このキャンセルをアイドルフレームで処理するよう設定します。
func process_default() -> CancelMotionExpression:
	return super.process_default()

## このキャンセルを物理フレームで処理するよう設定します。
func process_physics() -> CancelMotionExpression:
	return super.process_physics()

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
