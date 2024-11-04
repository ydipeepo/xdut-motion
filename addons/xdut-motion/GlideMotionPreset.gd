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

## 滑走アニメーションのプリセットを定義するためのリソースです。
class_name GlideMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## アニメーションの崩壊定数。
@export_range(XDUT_MotionTransition.EPSILON, 10.0, 0.1, "or_greater") var power := XDUT_GlideMotionTransition.DEFAULT_POWER

## アニメーションの時定数。
@export_range(0.0, 10.0, 0.1, "or_greater") var time_constant := XDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT

## アニメーションを休止させる位置デルタ。
@export_range(XDUT_MotionTransition.EPSILON, 10.0, 0.1, "or_greater") var rest_delta := XDUT_GlideMotionTransition.DEFAULT_REST_DELTA

## アニメーションで速度を重視するか位置を重視するか。
@export_enum("Velocity", "Position") var prefer: int = XDUT_GlideMotionTransition.DEFAULT_PREFER

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return trans_init is XDUT_CancelMotionTransitionInit

func apply(trans_init: XDUT_MotionTransitionInit) -> void:
	super(trans_init)
	trans_init.power = power
	trans_init.time_constant = time_constant
	trans_init.rest_delta = rest_delta
	trans_init.prefer = prefer

#-------------------------------------------------------------------------------

func _init(
	name := "",
	power := XDUT_GlideMotionTransition.DEFAULT_POWER,
	time_constant := XDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT,
	rest_delta := XDUT_GlideMotionTransition.DEFAULT_REST_DELTA,
	prefer: int = XDUT_GlideMotionTransition.DEFAULT_PREFER,
	delay := 0.0,
	process: int = XDUT_MotionTimer.PROCESS_DEFAULT) -> void:

	super(name, delay, process)
	self.power = power
	self.time_constant = time_constant
	self.rest_delta = rest_delta
	self.prefer = prefer
