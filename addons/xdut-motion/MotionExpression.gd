## アニメーションを構成するためのメソッドを含むクラスです。[br]
## `Awaitable` を継承し XDUT Task で待機することができます。
class_name MotionExpression extends Awaitable

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## このアニメーションの状態を取得します。
func get_state() -> int:
	return _completion.get_state()

## 遅延が設定されているかを取得します。
func has_delay() -> bool:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return false

## このアニメーションが完了するまで待機します。
func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

## このアニメーションに対しプリセットを適用します。
func preset(value: String) -> MotionExpression:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return null

## このアニメーションを開始するまでの遅延を設定します。
func delay(value: float) -> MotionExpression:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return null

## このアニメーションを処理するフレームを設定します。
func set_process(value: int) -> MotionExpression:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return self

## このアニメーションをアイドルフレームで処理するよう設定します。
func process_default() -> MotionExpression:
	return set_process(XDUT_MotionTimer.PROCESS_DEFAULT)

## このアニメーションを物理フレームで処理するよう設定します。
func process_physics() -> MotionExpression:
	return set_process(XDUT_MotionTimer.PROCESS_PHYSICS)

#-------------------------------------------------------------------------------

var _completion: Awaitable

func _init(completion: Awaitable) -> void:
	assert(completion != null)

	_completion = completion
