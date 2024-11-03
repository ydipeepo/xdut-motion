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

class_name MotionExpression extends Awaitable

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## このトランジションの状態を取得します。
func get_state() -> int:
	return _completion.get_state()

## このトランジションが完了するまで待機します。
func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

## プリセットを読み込みます。
func preset(value: String) -> MotionExpression:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return null

## 開始までの遅延を設定します。
func delay(value: float) -> MotionExpression:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return null

## プロセスフレームで処理するよう設定します。
func process_default() -> MotionExpression:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return null

## 物理フレームで処理するよう設定します。
func process_physics() -> MotionExpression:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return null

#-------------------------------------------------------------------------------

var _completion: XDUT_MotionCompletion

func _init(completion: XDUT_MotionCompletion) -> void:
	assert(completion != null)

	_completion = completion
