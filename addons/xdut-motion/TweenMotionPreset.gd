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

## Tween アニメーションのプリセットを定義するためのリソースです。
class_name TweenMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## アニメーションのトランジション関数。
@export_enum(
	"Linear",
	"Sine",
	"Quint",
	"Quart",
	"Quad",
	"Expo",
	"Elastic",
	"Cubic",
	"Circ",
	"Bounce",
	"Back") var trans: int = XDUT_TweenMotionTransition.DEFAULT_TRANS_TYPE

## アニメーションのイージング関数。
@export_enum(
	"In",
	"Out",
	"In and Out",
	"Out and In") var ease: int = XDUT_TweenMotionTransition.DEFAULT_EASE_TYPE

## アニメーションの期間。
@export_range(0.0, 10.0, 0.1, "or_greater") var duration := XDUT_TweenMotionTransition.DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return trans_init is XDUT_TweenMotionTransitionInit

func apply(trans_init: XDUT_MotionTransitionInit) -> void:
	super(trans_init)
	trans_init.ease = ease
	trans_init.trans = trans

#-------------------------------------------------------------------------------

func _init(
	name := "",
	trans: int = XDUT_TweenMotionTransition.DEFAULT_TRANS_TYPE,
	ease: int = XDUT_TweenMotionTransition.DEFAULT_EASE_TYPE,
	duration := XDUT_TweenMotionTransition.DEFAULT_DURATION,
	delay := 0.0,
	process: int = XDUT_MotionTimer.PROCESS_DEFAULT) -> void:

	super(name, delay, process)
	self.trans = trans
	self.ease = ease
	self.duration = duration
