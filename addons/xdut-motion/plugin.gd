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

@tool
extends EditorPlugin

#-------------------------------------------------------------------------------

static func _add_setting(
	key: String,
	default_value: Variant,
	property_hint: int,
	property_hint_string) -> void:

	if not ProjectSettings.has_setting(key):
		var property_info := {
			"name": key,
			"type": typeof(default_value),
			"hint": property_hint,
			"hint_string": property_hint_string,
		}

		ProjectSettings.set_setting(key, default_value)
		ProjectSettings.add_property_info(property_info)
		ProjectSettings.set_initial_value(key, default_value)
		ProjectSettings.set_as_basic(key, true)

static func _remove_setting(key: String) -> void:
	ProjectSettings.clear(key)

func _print(message: String, plugin_name: Variant = null) -> void:
	if OS.has_feature("editor"):
		if plugin_name == null:
			plugin_name = _get_plugin_name()
		print_rich("🧩 [u]", plugin_name, "[/u]: ", message)

func _get_plugin_name() -> String:
	return "XDUT Motion"

func _enter_tree() -> void:
	_add_setting("xdut/motion/processor/retention_duration", 5.0, PROPERTY_HINT_RANGE, "0,60")

	add_autoload_singleton("XDUT_MotionCanonical", "XDUT_MotionCanonical.gd")
	add_custom_type("MotionPresetBank", "Node", preload("MotionPresetBank.gd"), preload("MotionPresetBank.png"))

	_print("Activated.")

func _exit_tree() -> void:
	remove_custom_type("MotionPresetBank")
	remove_autoload_singleton("XDUT_MotionCanonical")

	_remove_setting("xdut/motion/processor/retention_duration")
