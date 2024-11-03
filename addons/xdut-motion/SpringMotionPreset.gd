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

class_name SpringMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(XDUT_MotionTransition.EPSILON, 1000.0, 1.0, "or_greater") var stiffness := XDUT_SpringMotionTransition.DEFAULT_STIFFNESS

@export_range(0.0, 1000.0, 1.0, "or_greater") var damping := XDUT_SpringMotionTransition.DEFAULT_DAMPING

@export_range(XDUT_MotionTransition.EPSILON, 1000.0, 1.0, "or_greater") var mass := XDUT_SpringMotionTransition.DEFAULT_MASS

@export_range(XDUT_MotionTransition.EPSILON, 10.0, 0.1, "or_greater") var rest_delta := XDUT_SpringMotionTransition.DEFAULT_REST_DELTA

@export_range(XDUT_MotionTransition.EPSILON, 10.0, 0.1, "or_greater", "units/s") var rest_speed := XDUT_SpringMotionTransition.DEFAULT_REST_SPEED

@export var limit_overdamping := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING

@export var limit_overshooting := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return trans_init is XDUT_SpringMotionTransitionInit

func apply(trans_init: XDUT_MotionTransitionInit) -> void:
	super(trans_init)
	trans_init.stiffness = stiffness
	trans_init.damping = damping
	trans_init.mass = mass
	trans_init.rest_delta = rest_delta
	trans_init.rest_speed = rest_speed
	trans_init.limit_overdamping = limit_overdamping
	trans_init.limit_overshooting = limit_overshooting

#-------------------------------------------------------------------------------

func _init(
	name := "",
	stiffness := XDUT_SpringMotionTransition.DEFAULT_STIFFNESS,
	damping := XDUT_SpringMotionTransition.DEFAULT_DAMPING,
	mass := XDUT_SpringMotionTransition.DEFAULT_MASS,
	rest_delta := XDUT_SpringMotionTransition.DEFAULT_REST_DELTA,
	rest_speed := XDUT_SpringMotionTransition.DEFAULT_REST_SPEED,
	limit_overdamping := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING,
	limit_overshooting := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING,
	delay := 0.0,
	process: int = XDUT_MotionTimer.PROCESS_DEFAULT) -> void:

	super(name, delay, process)
	self.stiffness = stiffness
	self.damping = damping
	self.mass = mass
	self.rest_delta = rest_delta
	self.rest_speed = rest_speed
	self.limit_overdamping = limit_overdamping
	self.limit_overshooting = limit_overshooting
