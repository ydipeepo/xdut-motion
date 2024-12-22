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

var _completion: XDUT_MotionCompletion

func _init(completion: XDUT_MotionCompletion) -> void:
	assert(completion != null)

	_completion = completion
