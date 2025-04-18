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

## このアニメーションを処理するフレームを設定します。
func set_process(value: int) -> SpringMotionExpression:
	match value:
		XDUT_MotionTimer.PROCESS_DEFAULT, \
		XDUT_MotionTimer.PROCESS_PHYSICS:
			_trans_init.process = value
	return self

## このアニメーションをアイドルフレームで処理するよう設定します。
func process_default() -> SpringMotionExpression:
	return super.process_default()

## このアニメーションを物理フレームで処理するよう設定します。
func process_physics() -> SpringMotionExpression:
	return super.process_physics()

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
	completion: Awaitable,
	trans_init: XDUT_SpringMotionTransitionInit,
	set_preset: Callable) -> void:

	super(completion)

	assert(trans_init != null)
	_trans_init = trans_init
	_set_preset = set_preset
