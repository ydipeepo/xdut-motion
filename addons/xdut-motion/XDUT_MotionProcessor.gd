@abstract
class_name XDUT_MotionProcessor extends Node

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func internal_motion_get_canonical() -> Node:
	if not is_instance_valid(_motion_canonical):
		_motion_canonical = Engine \
			.get_main_loop() \
			.root \
			.get_node("/root/XDUT_MotionCanonical")
	assert(is_instance_valid(_motion_canonical), "XDUT Motion is not activated.")
	return _motion_canonical

@abstract
func get_target_instance_id() -> int

@abstract
func get_target_name() -> String

@abstract
func get_target_key() -> String

@abstract
func set_target_position(state: XDUT_MotionState) -> bool

@abstract
func reset_state(
	trans_init: XDUT_MotionTransitionInit,
	state: XDUT_MotionState) -> XDUT_MotionState

func attach(
	trans_init: XDUT_MotionTransitionInit,
	completion: TaskBase) -> void:

	assert(completion.is_pending)

	set_process(false)
	set_physics_process(false)

	if _attaching_completion != null:
		_attaching_completion.release_complete()

	_attaching_completion = completion
	_attaching_trans_init = trans_init
	_attach_core.call_deferred()

#-------------------------------------------------------------------------------

static var _motion_canonical: Node

var _attaching_completion: TaskBase
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

	if _completion_wref != null:
		var last_completion := _completion_wref.get_ref() as TaskBase
		if last_completion != null:
			last_completion.release_complete()

	_completion_wref = null
	_retention_reminder_ticks = _retention_duration_ticks

	if completion.is_pending:
		_completion_wref = weakref(completion)

		_state = reset_state(trans_init, _state)
		if _state == null:
			return _free(Awaitable.STATE_CANCELED)

		_trans = trans_init.init(_trans)
		if _trans == null:
			if not set_target_position(_state):
				return _free(Awaitable.STATE_CANCELED)
			_release(Awaitable.STATE_COMPLETED)
			set_process(true)
		else:
			if not _state.can_set_initial_position(trans_init.initial_position):
				push_error(internal_motion_get_canonical()
					.translate(&"ERROR_DOES_NOT_MATCH_THE_STATE_REQUIREMENT")
					.format([&"initial_position"]))
				return _free(Awaitable.STATE_CANCELED)
			if not _state.can_set_final_position(trans_init.final_position):
				push_error(internal_motion_get_canonical()
					.translate(&"ERROR_DOES_NOT_MATCH_THE_STATE_REQUIREMENT")
					.format([&"final_position"]))
				return _free(Awaitable.STATE_CANCELED)
			if not _state.can_set_initial_velocity(trans_init.initial_velocity):
				push_error(internal_motion_get_canonical()
					.translate(&"ERROR_DOES_NOT_MATCH_THE_STATE_REQUIREMENT")
					.format([&"initial_velocity"]))
				return _free(Awaitable.STATE_CANCELED)
			match _trans.get_process():
				XDUT_MotionTimer.PROCESS_DEFAULT:
					set_process(true)
					set_physics_process(false)
				XDUT_MotionTimer.PROCESS_PHYSICS:
					set_process(false)
					set_physics_process(true)

func _is_cancel_requested() -> bool:
	if _completion_wref != null:
		var completion := _completion_wref.get_ref() as TaskBase
		if completion != null and completion.is_canceled:
			return true
	return false

func _release(state: int) -> void:
	if _completion_wref != null:
		var completion := _completion_wref.get_ref() as TaskBase
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
	_retention_duration_ticks = canonical.get_retention_duration_ticks()

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
				return _free(Awaitable.STATE_CANCELED)
			if _trans == null:
				return _release(Awaitable.STATE_COMPLETED)
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
