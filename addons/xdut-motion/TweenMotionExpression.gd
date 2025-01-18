## Tween アニメーションを構成するためのメソッドを含むクラスです。
class_name TweenMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## このアニメーションに対しプリセットを適用します。
func preset(value: String) -> TweenMotionExpression:
	_set_preset.call(value, _trans_init)
	return self

## このアニメーションを開始するまでの遅延を設定します。
func delay(value: float) -> TweenMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.delay = value
	return self

## このアニメーションを処理するフレームを設定します。
func set_process(value: int) -> TweenMotionExpression:
	match value:
		XDUT_MotionTimer.PROCESS_DEFAULT, \
		XDUT_MotionTimer.PROCESS_PHYSICS:
			_trans_init.process = value
	return self

## このアニメーションをアイドルフレームで処理するよう設定します。
func process_default() -> TweenMotionExpression:
	return super.process_default()

## このアニメーションを物理フレームで処理するよう設定します。
func process_physics() -> TweenMotionExpression:
	return super.process_physics()

## このアニメーションの期間を設定します。
func set_duration(value: float) -> TweenMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.duration = value
	return self

## このアニメーションのイージング関数を設定します。
func set_ease(value: int) -> TweenMotionExpression:
	_trans_init.ease_type = value
	return self

## このアニメーションのトランジション関数を設定します。
func set_trans(value: int) -> TweenMotionExpression:
	_trans_init.trans_type = value
	return self

## このアニメーションのイージング関数に [constant Tween.EASE_IN] を設定します。
func in_() -> TweenMotionExpression:
	return set_ease(Tween.EASE_IN)

## このアニメーションのイージング関数に [constant Tween.EASE_OUT] を設定します。
func out() -> TweenMotionExpression:
	return set_ease(Tween.EASE_OUT)

## このアニメーションのイージング関数に [constant Tween.EASE_IN_OUT] を設定します。
func in_out() -> TweenMotionExpression:
	return set_ease(Tween.EASE_IN_OUT)

## このアニメーションのイージング関数に [constant Tween.EASE_OUT_IN] を設定します。
func out_in() -> TweenMotionExpression:
	return set_ease(Tween.EASE_OUT_IN)

## このアニメーションのトランジション関数に [constant Tween.TRANS_LINEAR] を設定します。
func linear() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_LINEAR)

## このアニメーションのトランジション関数に [constant Tween.TRANS_QUAD] を設定します。
func quad() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_QUAD)

## このアニメーションのトランジション関数に [constant Tween.TRANS_CUBIC] を設定します。
func cubic() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_CUBIC)

## このアニメーションのトランジション関数に [constant Tween.TRANS_QUART] を設定します。
func quart() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_QUART)

## このアニメーションのトランジション関数に [constant Tween.TRANS_QUINT] を設定します。
func quint() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_QUINT)

## このアニメーションのトランジション関数に [constant Tween.TRANS_SINE] を設定します。
func sine() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_SINE)

## このアニメーションのトランジション関数に [constant Tween.TRANS_EXPO] を設定します。
func expo() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_EXPO)

## このアニメーションのトランジション関数に [constant Tween.TRANS_CIRC] を設定します。
func circ() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_CIRC)

## このアニメーションのトランジション関数に [constant Tween.TRANS_ELASTIC] を設定します。
func elastic() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_ELASTIC)

## このアニメーションのトランジション関数に [constant Tween.TRANS_BACK] を設定します。
func back() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_BACK)

## このアニメーションのトランジション関数に [constant Tween.TRANS_BOUNCE] を設定します。
func bounce() -> TweenMotionExpression:
	return set_trans(Tween.TRANS_BOUNCE)

## このアニメーションの初期位置を設定します。
func from(value: Variant) -> TweenMotionExpression:
	_trans_init.initial_position = value
	return self

## このアニメーションの最終位置を設定します。
func to(value: Variant) -> TweenMotionExpression:
	_trans_init.final_position = value
	return self

#-------------------------------------------------------------------------------

var _trans_init: XDUT_TweenMotionTransitionInit
var _set_preset: Callable

func _init(
	completion: Awaitable,
	trans_init: XDUT_TweenMotionTransitionInit,
	set_preset: Callable) -> void:

	super(completion)

	assert(trans_init != null)
	_trans_init = trans_init
	_set_preset = set_preset
