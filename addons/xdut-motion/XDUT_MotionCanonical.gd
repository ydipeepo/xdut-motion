extends Node

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func translate(translation_key: StringName) -> StringName:
	return _translation_domain.translate(translation_key)

func get_preset_mapper() -> XDUT_MotionPresetMapper:
	return _preset_mapper

func get_timer() -> XDUT_MotionTimer:
	return _timer

func get_retention_duration() -> float:
	return _processor_retention_duration

func get_retention_duration_ticks() -> int:
	return roundi(get_retention_duration() * 1000.0)

func attach(
	target: Node,
	target_key: String,
	trans_init: XDUT_MotionTransitionInit,
	cancel: Cancel) -> Awaitable:

	assert(target != null)
	assert(not target_key.is_empty())
	assert(trans_init != null)

	if cancel == null or not cancel.is_requested:
		var completion := TaskBase.new(cancel, &"MotionExpression")
		if completion.is_pending:
			var processor := _get_processor(target, target_key)
			if processor == null:
				processor = XDUT_PropertyMotionProcessor.new(target, target_key, self)
				processor.attach(trans_init, completion)
				add_child(processor)
			else:
				processor.attach(trans_init, completion)
				move_child(processor, get_child_count())
		return completion
	return Task.canceled()

func attach_method(
	target: Node,
	target_key: StringName,
	trans_init: XDUT_MotionTransitionInit,
	cancel: Cancel) -> Awaitable:

	assert(target != null)
	assert(not target_key.is_empty())
	assert(trans_init != null)

	if cancel == null or not cancel.is_requested:
		var completion := TaskBase.new(cancel, &"MotionExpression")
		if completion.is_pending:
			var processor := _get_processor(target, target_key)
			if processor == null:
				processor = XDUT_MethodMotionProcessor.new(target, target_key, self)
				processor.attach(trans_init, completion)
				add_child(processor)
			else:
				processor.attach(trans_init, completion)
				move_child(processor, get_child_count())
		return completion
	return Task.canceled()

#-------------------------------------------------------------------------------

const _TRANSLATION_EN: Dictionary[StringName, String] = {
	&"ERROR_CANNOT_CHANGE_PRESET_NAME_AT_RUNTIME": "Preset property '{0}' cannot be changed at runtime.",
	&"ERROR_DOES_NOT_MATCH_THE_STATE_REQUIREMENT": "State property '{0}' (or size if array) does not match the requirement.",
	&"ERROR_EMPTY_METHOD_NAME": "Method name is empty.",
	&"ERROR_EMPTY_PROPERTY_NAME": "Property name is empty.",
	&"ERROR_BAD_OBJECT": "The specified object is invalid.",
	&"ERROR_BAD_METHOD_NAME": "Invalid method '{0}' specified.",
	&"ERROR_BAD_PRESET_NAME": "Invalid preset '{0}' specified.",
	&"ERROR_BAD_PROPERTY_NAME": "Invalid property '{0}' specified.",
	&"ERROR_MUST_BE_GREATER_THAN_OR_EQUAL_TO_ZERO": "Value must be greater than or equal to zero: {0}",
	&"ERROR_MUST_BE_GREATER_THAN_ZERO": "Value must be greater than zero: {0}",
}

#push_warning("Preset name is empty at index ", preset_index, " on node '", name, "', skipped this preset.")

const _TRANSLATION_JA: Dictionary[StringName, String] = {
	&"ERROR_CANNOT_CHANGE_PRESET_NAME_AT_RUNTIME": "プリセットプロパティ '{0}' は実行時に変更できません。",
	&"ERROR_DOES_NOT_MATCH_THE_STATE_REQUIREMENT": "ステートプロパティ '{0}' (配列の場合はサイズ) が要件と一致しません。",
	&"ERROR_EMPTY_METHOD_NAME": "メソッド名が空です。",
	&"ERROR_EMPTY_PRESET_NAME": "プリセットノード '{1}' に含まれる {0} 番目のプリセット名が空です。スキップされました。",
	&"ERROR_EMPTY_PROPERTY_NAME": "プロパティ名が空です。",
	&"ERROR_BAD_OBJECT": "指定したオブジェクトは無効です。",
	&"ERROR_BAD_METHOD_NAME": "不正なメソッド '{0}' を指定しました。",
	&"ERROR_BAD_PRESET_NAME": "不正なプリセット '{0}' を指定しました。",
	&"ERROR_BAD_PROPERTY_NAME": "不正なプロパティ '{0}' を指定しました。",
	&"ERROR_MUST_BE_GREATER_THAN_OR_EQUAL_TO_ZERO": "値はゼロ以上でなければなりません: {0}",
	&"ERROR_MUST_BE_GREATER_THAN_ZERO": "値はゼロより大きくなければなりません: {0}",
}

var _translation_domain := TranslationDomain.new()
var _processor_retention_duration: float
var _preset_mapper: XDUT_MotionPresetMapper
var _timer: XDUT_MotionTimer

func _add_translation(
	locale: StringName,
	translation_map: Dictionary[StringName, String]) -> void:

	var translation := Translation.new()
	translation.locale = locale
	for translation_key: StringName in translation_map:
		translation.add_message(translation_key, translation_map[translation_key])

	_translation_domain.add_translation(translation)

func _get_processor(target: Node, target_key: String) -> XDUT_MotionProcessor:
	assert(target != null)
	assert(not target_key.is_empty())

	var index := get_child_count()
	while 0 < index:
		index -= 1
		var processor := get_child(index) as XDUT_MotionProcessor
		if (processor.get_target_instance_id() == target.get_instance_id() and
			processor.get_target_key() == target_key):
			return processor
	return null

func _collect_preset_banks(
	pivot_node: Node,
	preset_banks: Array[MotionPresetBank]) -> void:

	for node: Node in pivot_node.get_children():
		if node is MotionPresetBank:
			preset_banks.push_back(node)
	for node: Node in pivot_node.get_children():
		if node is not MotionPresetBank:
			_collect_preset_banks(node, preset_banks)

func _enter_tree() -> void:
	_add_translation(&"en", _TRANSLATION_EN)
	_add_translation(&"ja", _TRANSLATION_JA)

	_processor_retention_duration = ProjectSettings.get_setting("xdut/motion/processor/retention_duration", 5.0)
	
	_preset_mapper = XDUT_MotionPresetMapper.new()
	_preset_mapper.add(SpringMotionPreset.new("standard", 170.0, 26.0))
	_preset_mapper.add(SpringMotionPreset.new("gentle", 120.0, 14.0))
	_preset_mapper.add(SpringMotionPreset.new("wobbly", 180.0, 12.0))
	_preset_mapper.add(SpringMotionPreset.new("stiff", 210.0, 20.0))
	_preset_mapper.add(SpringMotionPreset.new("slow", 280.0, 60.0))
	_preset_mapper.add(SpringMotionPreset.new("molasses", 280.0, 120.0))
	_preset_mapper.add(TweenMotionPreset.new("linear"))
	_preset_mapper.add(TweenMotionPreset.new("quad_in", Tween.TRANS_QUAD, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("quad_out", Tween.TRANS_QUAD, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("quad_inout", Tween.TRANS_QUAD, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("quad_outin", Tween.TRANS_QUAD, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("cubic_in", Tween.TRANS_CUBIC, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("cubic_out", Tween.TRANS_CUBIC, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("cubic_inout", Tween.TRANS_CUBIC, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("cubic_outin", Tween.TRANS_CUBIC, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("quart_in", Tween.TRANS_QUART, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("quart_out", Tween.TRANS_QUART, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("quart_inout", Tween.TRANS_QUART, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("quart_outin", Tween.TRANS_QUART, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("quint_in", Tween.TRANS_QUINT, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("quint_out", Tween.TRANS_QUINT, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("quint_inout", Tween.TRANS_QUINT, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("quint_outin", Tween.TRANS_QUINT, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("sine_in", Tween.TRANS_SINE, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("sine_out", Tween.TRANS_SINE, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("sine_inout", Tween.TRANS_SINE, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("sine_outin", Tween.TRANS_SINE, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("expo_in", Tween.TRANS_EXPO, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("expo_out", Tween.TRANS_EXPO, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("expo_inout", Tween.TRANS_EXPO, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("expo_outin", Tween.TRANS_EXPO, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("circ_in", Tween.TRANS_CIRC, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("circ_out", Tween.TRANS_CIRC, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("circ_inout", Tween.TRANS_CIRC, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("circ_outin", Tween.TRANS_CIRC, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("elastic_in", Tween.TRANS_ELASTIC, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("elastic_out", Tween.TRANS_ELASTIC, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("elastic_inout", Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("elastic_outin", Tween.TRANS_ELASTIC, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("back_in", Tween.TRANS_BACK, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("back_out", Tween.TRANS_BACK, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("back_inout", Tween.TRANS_BACK, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("back_outin", Tween.TRANS_BACK, Tween.EASE_OUT_IN))
	_preset_mapper.add(TweenMotionPreset.new("bounce_in", Tween.TRANS_BOUNCE, Tween.EASE_IN))
	_preset_mapper.add(TweenMotionPreset.new("bounce_out", Tween.TRANS_BOUNCE, Tween.EASE_OUT))
	_preset_mapper.add(TweenMotionPreset.new("bounce_inout", Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT))
	_preset_mapper.add(TweenMotionPreset.new("bounce_outin", Tween.TRANS_BOUNCE, Tween.EASE_OUT_IN))

	var preset_banks: Array[MotionPresetBank] = []
	_collect_preset_banks(get_tree().root, preset_banks)
	for preset_bank: MotionPresetBank in preset_banks:
		preset_bank.map_presets(get_preset_mapper())

	_timer = XDUT_MotionTimer.new()

func _exit_tree() -> void:
	_preset_mapper = null
	_timer = null

func _process(delta: float) -> void:
	_timer.update(XDUT_MotionTimer.PROCESS_DEFAULT)

func _physics_process(delta: float) -> void:
	_timer.update(XDUT_MotionTimer.PROCESS_PHYSICS)
