class_name XDUT_MotionTimer

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

enum {
	PROCESS_DEFAULT,
	PROCESS_PHYSICS,
}

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_delta_ticks(process: int) -> int:
	match process:
		PROCESS_DEFAULT:
			return _default_delta_ticks
		PROCESS_PHYSICS:
			return _physics_delta_ticks
	return 0

func get_total_ticks(process: int) -> int:
	match process:
		PROCESS_DEFAULT:
			return _default_total_ticks
		PROCESS_PHYSICS:
			return _physics_total_ticks
	return 0

func get_delta(process: int) -> float:
	return get_delta_ticks(process) / 1000.0

func get_total(process: int) -> float:
	return get_total_ticks(process) / 1000.0

func update(process: int) -> void:
	var ticks := Time.get_ticks_msec() - _base_ticks
	var scale := Engine.time_scale
	match process:
		PROCESS_DEFAULT:
			var scaled_delta_ticks := ticks - _default_total_ticks
			if scale <= 0.0:
				scaled_delta_ticks = 0
			elif scale != 1.0:
				scaled_delta_ticks = roundi(scaled_delta_ticks * scale)
			_default_delta_ticks = scaled_delta_ticks
			_default_total_ticks += scaled_delta_ticks
		PROCESS_PHYSICS:
			var scaled_delta_ticks := ticks - _physics_total_ticks
			if scale <= 0.0:
				scaled_delta_ticks = 0
			elif scale != 1.0:
				scaled_delta_ticks = roundi(scaled_delta_ticks * scale)
			_physics_delta_ticks = scaled_delta_ticks
			_physics_total_ticks += scaled_delta_ticks

#-------------------------------------------------------------------------------

var _base_ticks: int
var _default_total_ticks: int
var _default_delta_ticks: int
var _physics_total_ticks: int
var _physics_delta_ticks: int

func _init() -> void:
	_base_ticks = Time.get_ticks_msec()
	_default_total_ticks = 0
	_default_delta_ticks = 0
	_physics_total_ticks = 0
	_physics_delta_ticks = 0
