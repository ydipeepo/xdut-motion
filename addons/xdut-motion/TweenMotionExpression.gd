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

class_name TweenMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## プリセットを読み込みます。
func preset(value: String) -> TweenMotionExpression:
	_set_preset.call(value, _trans_init)
	return self

## 開始までの遅延を設定します。
func delay(value: float) -> TweenMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.delay = value
	return self

## プロセスフレームで処理するよう設定します。
func process_default() -> TweenMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_DEFAULT
	return self

## 物理フレームで処理するよう設定します。
func process_physics() -> TweenMotionExpression:
	_trans_init.process = XDUT_MotionTimer.PROCESS_PHYSICS
	return self

## 期間を設定します。
func set_duration(value: float) -> TweenMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.duration = value
	return self

## トランジション関数に対し、どのようにイージングするかを設定します。
func set_ease(value: int) -> TweenMotionExpression:
	_trans_init.ease_type = value
	return self

## トランジション関数を設定します。
func set_trans(value: int) -> TweenMotionExpression:
	_trans_init.trans_type = value
	return self

## 加速していくようにします。([constant Tween.EASE_IN])
func in_() -> TweenMotionExpression:
	return set_ease(Tween.EASE_IN)

## 減速していくようにします。([constant Tween.EASE_OUT])
func out() -> TweenMotionExpression:
	return set_ease(Tween.EASE_OUT)

## 中間まで加速していき、そこから減速するようにします。([constant Tween.EASE_IN_OUT])
func in_out() -> TweenMotionExpression:
	return set_ease(Tween.EASE_IN_OUT)

## 中間まで減速していき、そこから加速するようにします。([constant Tween.EASE_OUT_IN])
func out_in() -> TweenMotionExpression:
	return set_ease(Tween.EASE_OUT_IN)

## 線形に補間します。([constant Tween.TRANS_LINEAR])
func linear() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_LINEAR)

## 二次関数で補間します。([constant Tween.TRANS_QUAD])
func quad() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_QUAD)

## 三次関数で補間します。([constant Tween.TRANS_CUBIC])
func cubic() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_CUBIC)

## 四次関数で補間します。([constant Tween.TRANS_QUART])
func quart() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_QUART)

## 五次関数で補間します。([constant Tween.TRANS_QUINT])
func quint() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_QUINT)

## 正弦関数で補間します。([constant Tween.TRANS_SINE])
func sine() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_SINE)

## 指数関数で補間します。([constant Tween.TRANS_EXPO])
func expo() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_EXPO)

## 平方根で補間します。([constant Tween.TRANS_CIRC])
func circ() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_CIRC)

## 弾性的な動きで補間します。([constant Tween.TRANS_ELASTIC])
func elastic() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_ELASTIC)

## バックアウト的な動きで補間します。([constant Tween.TRANS_BACK])
func back() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_BACK)

## 跳ねるような動きで補間します。([constant Tween.TRANS_BOUNCE])
func bounce() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_BOUNCE)

## このトランジションの開始位置を設定します。
func from(value: Variant) -> TweenMotionExpression:
	_trans_init.initial_position = value
	return self

## このトランジションの終了位置を設定します。
func to(value: Variant) -> TweenMotionExpression:
	_trans_init.final_position = value
	return self

#-------------------------------------------------------------------------------

var _trans_init: XDUT_TweenMotionTransitionInit
var _set_preset: Callable

func _init(
	completion: XDUT_MotionCompletion,
	trans_init: XDUT_TweenMotionTransitionInit,
	set_preset: Callable) -> void:

	super(completion)

	assert(trans_init != null)
	_trans_init = trans_init
	_set_preset = set_preset
