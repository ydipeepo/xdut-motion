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
