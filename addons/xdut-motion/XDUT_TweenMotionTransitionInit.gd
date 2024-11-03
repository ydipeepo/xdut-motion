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

class_name XDUT_TweenMotionTransitionInit extends XDUT_MotionTransitionInit

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var duration := XDUT_TweenMotionTransition.DEFAULT_DURATION
var ease_type := XDUT_TweenMotionTransition.DEFAULT_EASE_TYPE
var trans_type := XDUT_TweenMotionTransition.DEFAULT_TRANS_TYPE

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func init(previous_trans: XDUT_MotionTransition) -> XDUT_MotionTransition:
	assert(0.0 <= duration)
	assert(0.0 <= delay)

	var trans: XDUT_MotionTransition = XDUT_TweenMotionTransition.new(
		initial_position,
		final_position,
		initial_velocity,
		process,
		duration,
		trans_type,
		ease_type)
	if 0.0 < delay:
		trans = XDUT_DelayMotionTransition.new(
			previous_trans,
			trans,
			delay)
	return trans
