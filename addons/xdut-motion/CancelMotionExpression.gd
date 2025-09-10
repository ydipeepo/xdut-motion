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
		push_warning(internal_motion_get_canonical()
			.translate(&"ERROR_VALUE_MUST_BE_GREATER_THAN_OR_EQUAL_TO_ZERO")
			.format([value]))
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
	return super()

## このキャンセルを物理フレームで処理するよう設定します。
func process_physics() -> CancelMotionExpression:
	return super()

## 最終位置を設定します。
func at(value: Variant) -> CancelMotionExpression:
	_trans_init.final_position = value
	return self

#-------------------------------------------------------------------------------

var _trans_init: XDUT_CancelMotionTransitionInit
var _set_preset: Callable

func _init(
	completion: Awaitable,
	trans_init: XDUT_CancelMotionTransitionInit,
	set_preset: Callable) -> void:

	super(completion)
	assert(trans_init != null)
	_trans_init = trans_init
	_set_preset = set_preset
