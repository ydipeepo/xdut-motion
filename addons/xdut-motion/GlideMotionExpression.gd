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

class_name GlideMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## プリセットを読み込みます。
func preset(value: String) -> GlideMotionExpression:
	_set_preset.call(value, _trans_init)
	return self

## 開始までの遅延を設定します。
func delay(value: float) -> GlideMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.delay = value
	return self

## プロセスフレームで処理するよう設定します。
func process_default() -> GlideMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_DEFAULT
	return self

## 物理フレームで処理するよう設定します。
func process_physics() -> GlideMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_PHYSICS
	return self

## 崩壊定数を設定します。
func set_power(value: float) -> GlideMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.power = value
	return self

## 時定数を設定します。
func set_time_constant(value: float) -> GlideMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.time_constant = value
	return self

## 休止デルタを設定します。
func set_rest_delta(value: float) -> GlideMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.rest_delta = value
	return self

## 速度を重視するよう設定します。
func prefer_velocity() -> GlideMotionExpression:
	_trans_init.prefer = XDUT_GlideMotionTransition.PREFER_VELOCITY
	return self

## 位置を重視するよう設定します。
func prefer_position() -> GlideMotionExpression:
	_trans_init.prefer = XDUT_GlideMotionTransition.PREFER_POSITION
	return self

## このトランジションの開始位置を設定します。
func from(value: Variant) -> GlideMotionExpression:
	_trans_init.initial_position = value
	return self

## このトランジションの終了位置を設定します。
func to(value: Variant, auto_prefer := true) -> GlideMotionExpression:
	_trans_init.final_position = value
	if auto_prefer:
		_trans_init.prefer = XDUT_GlideMotionTransition.PREFER_POSITION
	return self

## このトランジションの開始速度を設定します。
func by(value: Variant, auto_prefer := true) -> GlideMotionExpression:
	_trans_init.initial_velocity = value
	if auto_prefer:
		_trans_init.prefer = XDUT_GlideMotionTransition.PREFER_VELOCITY
	return self

#-------------------------------------------------------------------------------

var _trans_init: XDUT_GlideMotionTransitionInit
var _set_preset: Callable

func _init(
	completion: XDUT_MotionCompletion,
	trans_init: XDUT_GlideMotionTransitionInit,
	set_preset: Callable) -> void:

	super(completion)

	assert(trans_init != null)
	_trans_init = trans_init
	_set_preset = set_preset
