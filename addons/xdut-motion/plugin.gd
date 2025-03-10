@tool
extends EditorPlugin

#-------------------------------------------------------------------------------

static func _add_setting(
	key: String,
	default_value: Variant,
	property_hint := PROPERTY_HINT_NONE,
	property_hint_string := "") -> void:

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
