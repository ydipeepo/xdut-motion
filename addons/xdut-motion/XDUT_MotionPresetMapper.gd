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
