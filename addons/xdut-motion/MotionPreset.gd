## アニメーションのプリセットを定義するための基底リソースです。
@abstract
class_name MotionPreset extends Resource

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_DELAY := 0.0
const MAX_DELAY := 60.0
const DEFAULT_DELAY := 0.0

const DEFAULT_PROCESS: int = XDUT_MotionTimer.PROCESS_DEFAULT

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## プリセット名。
@export
var name: String:
	get:
		return _name
	set(value):
		if _name_frozen:
			printerr(internal_get_motion_canonical()
				.translate(&"ERROR_PRESET_PROPERTY_CANNOT_CHANGE_AT_RUNTIME")
				.format(&"name"))
			return
		_name = value

## アニメーションを開始するまでの遅延。
@export_range(MIN_DELAY, MAX_DELAY, 0.001, "or_greater", "suffix:s")
var delay := DEFAULT_DELAY

## アニメーションを処理するフレームタイプ。
@export_enum("Default", "Physics")
var process := DEFAULT_PROCESS

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func internal_get_motion_canonical() -> Node:
	if not is_instance_valid(_motion_canonical):
		_motion_canonical = Engine \
			.get_main_loop() \
			.root \
			.get_node("/root/XDUT_MotionCanonical")
	assert(is_instance_valid(_motion_canonical), "XDUT Motion is not activated.")
	return _motion_canonical

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

static var _motion_canonical: Node

var _name: String
var _name_frozen := false

func _init(
	name := "",
	delay := DEFAULT_DELAY,
	process := DEFAULT_PROCESS) -> void:

	_name = name
	self.delay = delay
	self.process = process
