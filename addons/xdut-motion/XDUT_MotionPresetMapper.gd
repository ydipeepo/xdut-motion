class_name XDUT_MotionPresetMapper

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func apply(preset_name: String, trans_init: XDUT_MotionTransitionInit) -> bool:
	if preset_name in _preset_map:
		var presets: Array[MotionPreset] = _preset_map[preset_name]
		for preset_index: int in range(presets.size() - 1, -1, -1):
			var preset: MotionPreset = presets[preset_index]
			if preset.can_apply(trans_init):
				preset.apply(trans_init)
				return true
	return false

func add(preset: MotionPreset) -> void:
	assert(preset != null)

	preset.freeze_name()
	if preset.name in _preset_map:
		_preset_map[preset.name].push_back(preset)
	else:
		var presets: Array[MotionPreset] = [preset]
		_preset_map[preset.name] = presets

func remove(preset: MotionPreset) -> void:
	assert(preset != null)

	if preset.name in _preset_map:
		var presets: Array = _preset_map[preset.name]
		var preset_index := presets.rfind(preset)
		if preset_index != -1:
			presets.remove_at(preset_index)
			if presets.is_empty():
				_preset_map.erase(preset.name)
	preset.unfreeze_name()

#-------------------------------------------------------------------------------

var _preset_map: Dictionary = {}
