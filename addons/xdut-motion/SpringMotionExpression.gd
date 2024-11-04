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

## バネアニメーションを構成するためのメソッドを含むクラスです。
class_name SpringMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## このアニメーションに対しプリセットを適用します。
func preset(value: String) -> SpringMotionExpression:
	_set_preset.call(value, _trans_init)
	return self

## このアニメーションを開始するまでの遅延を設定します。
func delay(value: float) -> SpringMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.delay = value
	return self

## このアニメーションをアイドルフレームで処理するよう設定します。
func process_default() -> SpringMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_DEFAULT
	return self

## このアニメーションを物理フレームで処理するよう設定します。
func process_physics() -> SpringMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_PHYSICS
	return self

## このアニメーションの剛性を設定します。
func set_stiffness(value: float) -> SpringMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.stiffness = value
	return self

## このアニメーションの減衰を設定します。
func set_damping(value: float) -> SpringMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.damping = value
	return self

## このアニメーションの質量を設定します。
func set_mass(value: float) -> SpringMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.mass = value
	return self

## このアニメーションを休止させる位置デルタを設定します。
func set_rest_speed(value: float) -> SpringMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.rest_speed = value
	return self

## このアニメーションを休止させる速度を設定します。
func set_rest_delta(value: float) -> SpringMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.rest_delta = value
	return self

## このアニメーションが過減衰とならないよう制限します。
func limit_overdamping(value := true) -> SpringMotionExpression:
	_trans_init.limit_overdamping = value
	return self

## このアニメーションがオーバーシュートしないよう制限します。
func limit_overshooting(value := true) -> SpringMotionExpression:
	_trans_init.limit_overshooting = value
	return self

## このアニメーションの初期位置を設定します。
func from(value: Variant) -> SpringMotionExpression:
	_trans_init.initial_position = value
	return self

## このアニメーションの最終位置を設定します。
func to(value: Variant) -> SpringMotionExpression:
	_trans_init.final_position = value
	return self

## このアニメーションの初期速度を設定します。
func by(value: Variant) -> SpringMotionExpression:
	_trans_init.initial_velocity = value
	return self

#-------------------------------------------------------------------------------

var _trans_init: XDUT_SpringMotionTransitionInit
var _set_preset: Callable

func _init(
	completion: XDUT_MotionCompletion,
	trans_init: XDUT_SpringMotionTransitionInit,
	set_preset: Callable) -> void:

	super(completion)

	assert(trans_init != null)
	_trans_init = trans_init
	_set_preset = set_preset
