## プリセットを XDUT Motion に登録するためのノードです。
@icon("MotionPresetBank.png")
class_name MotionPresetBank extends Node

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## [MotionPreset] のリスト。インスペクターから操作します。
@export var presets: Array[MotionPreset] = []

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func map_presets(preset_mapper: XDUT_MotionPresetMapper) -> void:
	for preset_index: int in presets.size():
		var preset: MotionPreset = presets[preset_index]
		if preset == null:
			continue
		if preset.name.is_empty():
			push_warning("Preset name is empty at index ", preset_index, " on node '", name, "', skipped this preset.")
			continue
		preset_mapper.add(preset)

#-------------------------------------------------------------------------------

var _canonical: Node

func _enter_tree() -> void:
	_canonical = get_node("/root/XDUT_MotionCanonical")
	if is_instance_valid(_canonical):
		map_presets(_canonical.get_preset_mapper())

func _exit_tree() -> void:
	if is_instance_valid(_canonical):
		var preset_mapper: XDUT_MotionPresetMapper = _canonical.get_preset_mapper()
		for preset: MotionPreset in presets:
			if preset == null:
				continue
			if preset.name.is_empty():
				continue
			preset_mapper.remove(preset)

	_canonical = null
