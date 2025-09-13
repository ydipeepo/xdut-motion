## アニメーションを構成するためのメソッドを含むクラスです。[br]
## `Awaitable` を継承し XDUT Task で待機することができます。
@abstract
class_name MotionExpression extends Awaitable

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func internal_get_motion_canonical() -> Node:
	if not is_instance_valid(_motion_canonical):
		_motion_canonical = Engine \
			.get_main_loop() \
			.root \
			.get_node("/root/XDUT_MotionCanonical")
	assert(is_instance_valid(_motion_canonical), "XDUT Motion is not activated.")
	return _motion_canonical

## このアニメーションの状態を取得します。
func get_state() -> int:
	return _completion.get_state()

## このアニメーションが完了するまで待機します。
func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

## このアニメーションに対しプリセットを適用します。
@abstract
func preset(value: String) -> MotionExpression

## このアニメーションを開始するまでの遅延を設定します。
@abstract
func delay(value: float) -> MotionExpression

## このアニメーションを処理するフレームを設定します。
@abstract
func set_process(value: int) -> MotionExpression

## このアニメーションをアイドルフレームで処理するよう設定します。
func process_default() -> MotionExpression:
	return set_process(XDUT_MotionTimer.PROCESS_DEFAULT)

## このアニメーションを物理フレームで処理するよう設定します。
func process_physics() -> MotionExpression:
	return set_process(XDUT_MotionTimer.PROCESS_PHYSICS)

#-------------------------------------------------------------------------------

static var _motion_canonical: Node

var _completion: Awaitable

func _init(completion: Awaitable) -> void:
	assert(completion != null)

	_completion = completion
