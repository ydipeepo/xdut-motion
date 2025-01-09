## 滑走アニメーションを構成するためのメソッドを含むクラスです。
class_name GlideMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## このアニメーションに対しプリセットを適用します。
func preset(value: String) -> GlideMotionExpression:
	_set_preset.call(value, _trans_init)
	return self

## このアニメーションを開始するまでの遅延を設定します。
func delay(value: float) -> GlideMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.delay = value
	return self

## このアニメーションを処理するフレームを設定します。
func set_process(value: int) -> GlideMotionExpression:
	match value:
		XDUT_MotionTimer.PROCESS_DEFAULT, \
		XDUT_MotionTimer.PROCESS_PHYSICS:
			_trans_init.process = value
	return self

## このアニメーションをアイドルフレームで処理するよう設定します。
func process_default() -> GlideMotionExpression:
	return super.process_default()

## このアニメーションを物理フレームで処理するよう設定します。
func process_physics() -> GlideMotionExpression:
	return super.process_default()

## このアニメーションの崩壊定数を設定します。
func set_power(value: float) -> GlideMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.power = value
	return self

## このアニメーションの時定数を設定します。
func set_time_constant(value: float) -> GlideMotionExpression:
	if value < 0.0:
		push_warning("'value' must be greater than or equal to zero: ", value)
		value = 0.0
	_trans_init.time_constant = value
	return self

## このアニメーションを休止させる位置デルタを設定します。
func set_rest_delta(value: float) -> GlideMotionExpression:
	if value < XDUT_MotionTransition.EPSILON:
		push_warning("'value' must be greater than zero: ", value)
		value = XDUT_MotionTransition.EPSILON
	_trans_init.rest_delta = value
	return self

## このアニメーションが何を重視するか設定します。
func set_prefer(value: int) -> GlideMotionExpression:
	match value:
		XDUT_GlideMotionTransition.PREFER_VELOCITY, \
		XDUT_GlideMotionTransition.PREFER_POSITION:
			_trans_init.prefer = value
	return self

## このアニメーションを速度を重視するよう設定します。
func prefer_velocity() -> GlideMotionExpression:
	_trans_init.prefer = XDUT_GlideMotionTransition.PREFER_VELOCITY
	return self

## このアニメーションを位置を重視するよう設定します。
func prefer_position() -> GlideMotionExpression:
	_trans_init.prefer = XDUT_GlideMotionTransition.PREFER_POSITION
	return self

## このアニメーションの初期位置を設定します。
func from(value: Variant) -> GlideMotionExpression:
	_trans_init.initial_position = value
	return self

## このアニメーションの最終位置を設定します。
func to(value: Variant, auto_prefer := true) -> GlideMotionExpression:
	_trans_init.final_position = value
	if auto_prefer:
		_trans_init.prefer = XDUT_GlideMotionTransition.PREFER_POSITION
	return self

## このアニメーションの初期速度を設定します。
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
