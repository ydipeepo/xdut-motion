## XDUT Motion の起点となるクラスです。
class_name Motion

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func internal_get_motion_canonical() -> Node:
	if not is_instance_valid(_motion_canonical):
		_motion_canonical = Engine \
			.get_main_loop() \
			.root \
			.get_node("/root/XDUT_MotionCanonical")
	assert(is_instance_valid(_motion_canonical), "XDUT Motion is not activated.")
	return _motion_canonical

## プロパティに対しバネ (減衰振動) アニメーションをスケジュールします。
static func spring(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> SpringMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if property_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_PROPERTY_NAME"))
		return null
	#if not property_name in object:
	#	push_error(internal_get_motion_canonical()
	#		.translate(&"ERROR_BAD_PROPERTY_NAME"))
	#	return null

	var trans_init := XDUT_SpringMotionTransitionInit.new()
	return SpringMotionExpression.new(
		internal_get_motion_canonical()
			.attach(
				object,
				property_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

## メソッドに対しバネ (減衰振動) アニメーションをスケジュールします。
static func spring_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> SpringMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if method_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_METHOD_NAME"))
		return null
	if not object.has_method(method_name):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_METHOD_NAME")
			.format([method_name]))
		return null

	var trans_init := XDUT_SpringMotionTransitionInit.new()
	return SpringMotionExpression.new(
		internal_get_motion_canonical()
			.attach_method(
				object,
				method_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

## プロパティに対し滑走 (指数関数減衰) アニメーションをスケジュールします。
static func glide(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> GlideMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if property_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_PROPERTY_NAME"))
		return null
	#if not property_name in object:
	#	push_error(internal_get_motion_canonical()
	#		.translate(&"ERROR_BAD_PROPERTY_NAME"))
	#	return null

	var trans_init := XDUT_GlideMotionTransitionInit.new()
	return GlideMotionExpression.new(
		internal_get_motion_canonical()
			.attach(
				object,
				property_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

## メソッドに対し滑走 (指数関数減衰) アニメーションをスケジュールします。
static func glide_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> GlideMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if method_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_METHOD_NAME"))
		return null
	if not object.has_method(method_name):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_METHOD_NAME")
			.format([method_name]))
		return null

	var trans_init := XDUT_GlideMotionTransitionInit.new()
	return GlideMotionExpression.new(
		internal_get_motion_canonical()
			.attach_method(
				object,
				method_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

## プロパティに対し Tween アニメーションをスケジュールします。
static func tween(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> TweenMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if property_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_PROPERTY_NAME"))
		return null
	#if not property_name in object:
	#	push_error(internal_get_motion_canonical()
	#		.translate(&"ERROR_BAD_PROPERTY_NAME"))
	#	return null

	var trans_init := XDUT_TweenMotionTransitionInit.new()
	return TweenMotionExpression.new(
		internal_get_motion_canonical()
			.attach(
				object,
				property_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

## メソッドに対し Tween アニメーションをスケジュールします。
static func tween_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> TweenMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if method_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_METHOD_NAME"))
		return null
	if not object.has_method(method_name):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_METHOD_NAME")
			.format([method_name]))
		return null

	var trans_init := XDUT_TweenMotionTransitionInit.new()
	return TweenMotionExpression.new(
		internal_get_motion_canonical()
			.attach_method(
				object,
				method_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

## プロパティに対しアクティブになっているアニメーションをキャンセルします。
static func cancel(
	object: Node,
	property_name: String,
	cancel: Cancel = null) -> CancelMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if property_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_PROPERTY_NAME"))
		return null
	#if not property_name in object:
	#	push_error(internal_get_motion_canonical()
	#		.translate(&"ERROR_BAD_PROPERTY_NAME"))
	#	return null

	var trans_init := XDUT_CancelMotionTransitionInit.new()
	return CancelMotionExpression.new(
		internal_get_motion_canonical()
			.attach(
				object,
				property_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

## メソッドに対しアクティブになっているアニメーションをキャンセルします。
static func cancel_method(
	object: Node,
	method_name: String,
	cancel: Cancel = null) -> CancelMotionExpression:

	if not is_instance_valid(object):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_OBJECT"))
		return null
	if method_name.is_empty():
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_EMPTY_METHOD_NAME"))
		return null
	if not object.has_method(method_name):
		push_error(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_METHOD_NAME")
			.format([method_name]))
		return null

	var trans_init := XDUT_CancelMotionTransitionInit.new()
	return CancelMotionExpression.new(
		internal_get_motion_canonical()
			.attach_method(
				object,
				method_name,
				trans_init,
				cancel),
		trans_init,
		_set_preset)

#-------------------------------------------------------------------------------

static var _motion_canonical: Node

static func _set_preset(preset_name: String, trans_init: XDUT_MotionTransitionInit) -> void:
	var preset_mapper: XDUT_MotionPresetMapper = internal_get_motion_canonical() \
		.get_preset_mapper()
	if not preset_mapper.apply(preset_name, trans_init):
		push_warning(internal_get_motion_canonical()
			.translate(&"ERROR_BAD_PRESET_NAME")
			.format([preset_name]))
		return
