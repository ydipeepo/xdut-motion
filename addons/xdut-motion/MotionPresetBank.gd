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

static func internal_get_motion_canonical_safe() -> Node:
	if not is_instance_valid(_motion_canonical):
		_motion_canonical = Engine \
			.get_main_loop() \
			.root \
			.get_node("/root/XDUT_MotionCanonical")
	if not is_instance_valid(_motion_canonical):
		_motion_canonical = null
	return _motion_canonical

static func internal_get_motion_canonical() -> Node:
	var canonical := internal_get_motion_canonical_safe()
	assert(is_instance_valid(canonical), "XDUT Motion is not activated.")
	return canonical

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

static var _motion_canonical: Node

func _enter_tree() -> void:
	var canonical := internal_get_motion_canonical_safe()
	if canonical != null:
		map_presets(canonical.get_preset_mapper())

func _exit_tree() -> void:
	var canonical := internal_get_motion_canonical_safe()
	if canonical != null:
		var preset_mapper: XDUT_MotionPresetMapper = canonical.get_preset_mapper()
		for preset: MotionPreset in presets:
			if preset == null:
				continue
			if preset.name.is_empty():
				continue
			preset_mapper.remove(preset)
