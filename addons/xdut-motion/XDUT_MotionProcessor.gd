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

class_name XDUT_MotionProcessor extends Node

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_instance_id() -> int:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return 0

func get_target_name() -> String:
	#
	# 継承先で実装する必要があります。
	#

	assert(false)
	return ""

func get_target_key() -> String:
	#
	# 継承先で実装する必要があります。
	#
	
	assert(false)
	return ""

func set_target_position(state: XDUT_MotionState) -> bool:
	#
	# 継承先で実装します。
	#

	assert(false)
	return false

func create_state(trans_init: XDUT_MotionTransitionInit) -> XDUT_MotionState:
	#
	# 継承先で実装します。
	#

	assert(false)
	return null

func attach(
	trans_init: XDUT_MotionTransitionInit,
	completion: XDUT_MotionCompletion) -> void:

	assert(completion.is_pending)

	set_process(false)
	set_physics_process(false)

	if _attaching_completion != null:
		_attaching_completion.release_complete()

	_attaching_completion = completion
	_attaching_trans_init = trans_init
	_attach_core.call_deferred()

#-------------------------------------------------------------------------------

var _attaching_completion: XDUT_MotionCompletion
var _attaching_trans_init: XDUT_MotionTransitionInit
var _completion_wref: WeakRef
var _timer: XDUT_MotionTimer
var _state: XDUT_MotionState
var _trans: XDUT_MotionTransition
var _retention_duration_ticks: int
var _retention_reminder_ticks: int

func _attach_core() -> void:
	if _attaching_trans_init == null:
		return

	var trans_init := _attaching_trans_init
	var completion := _attaching_completion
	_attaching_trans_init = null
	_attaching_completion = null

	_completion_wref = null
	_retention_reminder_ticks = _retention_duration_ticks

	if completion.is_pending:
		_completion_wref = weakref(completion)

		if _state == null:
			_state = create_state(trans_init)
			if _state == null:
				_free(Awaitable.STATE_CANCELED)
				return

		_trans = trans_init.init(_trans)
		if _trans == null:
			if not set_target_position(_state):
				_free(Awaitable.STATE_CANCELED)
				return
			_release(Awaitable.STATE_COMPLETED)
			set_process(true)
		else:
			if not _state.can_set_initial_position(trans_init.initial_position):
				push_error("'initial_position' type (or size if is it array) does not match the state requirement.")
				_free(Awaitable.STATE_CANCELED)
				return
			if not _state.can_set_final_position(trans_init.final_position):
				push_error("'final_position' type (or size if is it array) does not match the state requirement.")
				_free(Awaitable.STATE_CANCELED)
				return
			if not _state.can_set_initial_velocity(trans_init.initial_velocity):
				push_error("'initial_velocity' type (or size if is it array) does not match the state requirement.")
				_free(Awaitable.STATE_CANCELED)
				return
			match _trans.get_process():
				XDUT_MotionTimer.PROCESS_DEFAULT:
					set_process(true)
					set_physics_process(false)
				XDUT_MotionTimer.PROCESS_PHYSICS:
					set_process(false)
					set_physics_process(true)

func _is_cancel_requested() -> bool:
	if _completion_wref != null:
		var completion := _completion_wref.get_ref() as XDUT_MotionCompletion
		if completion != null and completion.is_canceled:
			return true
	return false

func _release(state: int) -> void:
	if _completion_wref != null:
		var completion := _completion_wref.get_ref() as XDUT_MotionCompletion
		_completion_wref = null
		if completion != null:
			match state:
				Awaitable.STATE_COMPLETED:
					completion.release_complete()
				Awaitable.STATE_CANCELED:
					completion.release_cancel()

func _free(state: Variant = null) -> void:
	var parent := get_parent()
	assert(parent != null)

	if state is int:
		_release(state)
	parent.remove_child(self)
	set_process(false)
	set_physics_process(false)
	queue_free()

func _init(canonical: Node) -> void:
	assert(canonical != null)
	_timer = canonical.get_timer()
	_retention_duration_ticks = canonical.get_retention_duration()

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

	name = "%s.%s#%d" % [
		get_target_name(),
		get_target_key(),
		get_target_instance_id(),
	]

func _process_core(delta_ticks: int, total_ticks: int) -> void:
	if _trans != null:
		if _is_cancel_requested():
			_trans = null
		else:
			_trans = _trans.next(_state, delta_ticks, total_ticks)
			if not set_target_position(_state):
				_free(Awaitable.STATE_CANCELED)
				return
			if _trans == null:
				_release(Awaitable.STATE_COMPLETED)
				return
			match _trans.get_process():
				XDUT_MotionTimer.PROCESS_DEFAULT:
					set_process(true)
					set_physics_process(false)
				XDUT_MotionTimer.PROCESS_PHYSICS:
					set_process(false)
					set_physics_process(true)
	else:
		_retention_reminder_ticks -= delta_ticks
		if _retention_reminder_ticks <= 0.0:
			_free()
			return

func _process(delta: float) -> void:
	_process_core(
		_timer.get_delta_ticks(XDUT_MotionTimer.PROCESS_DEFAULT),
		_timer.get_total_ticks(XDUT_MotionTimer.PROCESS_DEFAULT))

func _physics_process(delta: float) -> void:
	_process_core(
		_timer.get_delta_ticks(XDUT_MotionTimer.PROCESS_PHYSICS),
		_timer.get_total_ticks(XDUT_MotionTimer.PROCESS_PHYSICS))
