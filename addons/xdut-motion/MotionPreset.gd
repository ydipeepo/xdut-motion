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

## アニメーションのプリセットを定義するための基底リソースです。
class_name MotionPreset extends Resource

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## プリセット名。
@export var name: String:
	get:
		return _name
	set(value):
		if _name_frozen:
			printerr("Preset name cannot be changed at runtime.")
			return
		_name = value

## アニメーションを開始するまでの遅延。
@export_range(0.0, 60.0, 0.1, "or_greater", "suffix:s") var delay := 0.0

## アニメーションを処理するフレームタイプ。
@export_enum("Default", "Physics") var process: int = XDUT_MotionTimer.PROCESS_DEFAULT

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return true

func apply(trans_init: XDUT_MotionTransitionInit) -> void:
	trans_init.delay = delay
	trans_init.process = process

func freeze_name() -> void:
	_name_frozen = true

func unfreeze_name() -> void:
	_name_frozen = false

#-------------------------------------------------------------------------------

var _name: String
var _name_frozen := false

func _init(
	name := "",
	delay := 0.0,
	process: int = XDUT_MotionTimer.PROCESS_DEFAULT) -> void:

	_name = name
	self.delay = delay
	self.process = process
