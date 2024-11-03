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

extends Node

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_preset_mapper() -> XDUT_MotionPresetMapper:
	return _preset_mapper

func get_timer() -> XDUT_MotionTimer:
	return _timer

func get_retention_duration() -> float:
	return ProjectSettings.get_setting("xdut/motion/processor/retention_duration", 5.0)

func get_retention_duration_ticks() -> int:
	return roundi(get_retention_duration() * 1000.0)

func attach(
	target: Node,
	target_key: String,
	trans_init: XDUT_MotionTransitionInit,
	cancel: Cancel) -> XDUT_MotionCompletion:

	assert(target != null)
	assert(not target_key.is_empty())
	assert(trans_init != null)

	var completion := XDUT_MotionCompletion.new(cancel)
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

func attach_method(
	target: Node,
	target_key: StringName,
	trans_init: XDUT_MotionTransitionInit,
	cancel: Cancel) -> XDUT_MotionCompletion:

	assert(target != null)
	assert(not target_key.is_empty())
	assert(trans_init != null)

	var completion := XDUT_MotionCompletion.new(cancel)
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

#-------------------------------------------------------------------------------

var _preset_mapper: XDUT_MotionPresetMapper
var _timer: XDUT_MotionTimer

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

func _enter_tree() -> void:
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
	_timer = XDUT_MotionTimer.new()

func _exit_tree() -> void:
	_preset_mapper = null
	_timer = null

func _process(delta: float) -> void:
	_timer.update(XDUT_MotionTimer.PROCESS_DEFAULT)

func _physics_process(delta: float) -> void:
	_timer.update(XDUT_MotionTimer.PROCESS_PHYSICS)
