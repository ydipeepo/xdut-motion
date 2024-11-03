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

class_name Motion

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## プロパティに対しバネ (減衰振動) アニメーションをスケジュールします。
static func spring(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> SpringMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if property_name.is_empty():
		push_error("'property_name' is empty.")
		return null

	var trans_init := XDUT_SpringMotionTransitionInit.new()
	var completion := _attach(
		object,
		property_name,
		trans_init,
		cancel)
	return null if completion == null else SpringMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

## メソッドに対しバネ (減衰振動) アニメーションをスケジュールします。
static func spring_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> SpringMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if method_name.is_empty():
		push_error("'method_name' is empty.")
		return null
	if not object.has_method(method_name):
		push_error("Method '", method_name, "' not found: ", object.name)
		return null

	var trans_init := XDUT_SpringMotionTransitionInit.new()
	var completion := _attach_method(
		object,
		method_name,
		trans_init,
		cancel)
	return null if completion == null else SpringMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

## プロパティに対し滑走 (指数関数減衰) アニメーションをスケジュールします。
static func glide(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> GlideMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if property_name.is_empty():
		push_error("'property_name' is empty.")
		return null

	var trans_init := XDUT_GlideMotionTransitionInit.new()
	var completion := _attach(
		object,
		property_name,
		trans_init,
		cancel)
	return null if completion == null else GlideMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

## メソッドに対し滑走 (指数関数減衰) アニメーションをスケジュールします。
static func glide_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> GlideMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if method_name.is_empty():
		push_error("'method_name' is empty.")
		return null
	if not object.has_method(method_name):
		push_error("Method '", method_name, "' not found: ", object.name)
		return null

	var trans_init := XDUT_GlideMotionTransitionInit.new()
	var completion := _attach_method(
		object,
		method_name,
		trans_init,
		cancel)
	return null if completion == null else GlideMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

## プロパティに対し Tween アニメーションをスケジュールします。
static func tween(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> TweenMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if property_name.is_empty():
		push_error("'property_name' is empty.")
		return null

	var trans_init := XDUT_TweenMotionTransitionInit.new()
	var completion := _attach(
		object,
		property_name,
		trans_init,
		cancel)
	return null if completion == null else TweenMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

## メソッドに対し Tween アニメーションをスケジュールします。
static func tween_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> TweenMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if method_name.is_empty():
		push_error("'method_name' is empty.")
		return null
	if not object.has_method(method_name):
		push_error("Method '", method_name, "' not found: ", object.name)
		return null

	var trans_init := XDUT_TweenMotionTransitionInit.new()
	var completion := _attach_method(
		object,
		method_name,
		trans_init,
		cancel)
	return null if completion == null else TweenMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

## プロパティに対しアクティブになっているアニメーションをキャンセルします。
static func cancel(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> CancelMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if property_name.is_empty():
		push_error("'property_name' is empty.")
		return null

	var trans_init := XDUT_CancelMotionTransitionInit.new()
	var completion := _attach(
		object,
		property_name,
		trans_init,
		cancel)
	return null if completion == null else CancelMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

## メソッドに対しアクティブになっているアニメーションをキャンセルします。
static func cancel_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> CancelMotionExpression:

	if not is_instance_valid(object):
		push_error("'object' is pointing invalid instance.")
		return null
	if method_name.is_empty():
		push_error("'method_name' is empty.")
		return null
	if not object.has_method(method_name):
		push_error("Method '", method_name, "' not found: ", object.name)
		return null

	var trans_init := XDUT_CancelMotionTransitionInit.new()
	var completion := _attach_method(
		object,
		method_name,
		trans_init,
		cancel)
	return null if completion == null else CancelMotionExpression.new(
		completion,
		trans_init,
		_set_preset)

#-------------------------------------------------------------------------------

static var _canonical: Node

static func _get_canonical() -> Node:
	if not is_instance_valid(_canonical):
		var main_loop := Engine.get_main_loop()
		_canonical = main_loop.root.get_node("/root/XDUT_MotionCanonical")
		if _canonical == null:
			push_error("XDUT Motion has not been activated. Please check your project settings.")
	return _canonical

static func _set_preset(preset_name: String, trans_init: XDUT_MotionTransitionInit) -> void:
	var canonical := _get_canonical()
	if canonical == null:
		return
	var preset_mapper: XDUT_MotionPresetMapper = canonical.get_preset_mapper()
	if not preset_mapper.apply(preset_name, trans_init):
		push_warning("Preset '", preset_name, "' not found.")
		return

static func _attach(
	target: Node,
	target_key: String,
	trans_init: XDUT_MotionTransitionInit,
	cancel: Cancel) -> XDUT_MotionCompletion:

	var canonical := _get_canonical()
	return null if canonical == null else canonical.attach(
		target,
		target_key,
		trans_init,
		cancel)

static func _attach_method(
	target: Node,
	target_key: StringName,
	trans_init: XDUT_MotionTransitionInit,
	cancel: Cancel) -> XDUT_MotionCompletion:

	var canonical := _get_canonical()
	return null if canonical == null else canonical.attach_method(
		target,
		target_key,
		trans_init,
		cancel)
