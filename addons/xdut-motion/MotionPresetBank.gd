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
