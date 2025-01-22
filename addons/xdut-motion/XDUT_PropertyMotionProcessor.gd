class_name XDUT_PropertyMotionProcessor extends XDUT_MotionProcessor

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_instance_id() -> int:
	return _target_instance_id

func get_target_name() -> String:
	return _target_name

func get_target_key() -> String:
	return _target_key

func set_target_position(state: XDUT_MotionState) -> bool:
	if is_instance_id_valid(_target_instance_id) and not _target.is_queued_for_deletion():
		_target.set_indexed(_target_key, state.get_position())
		return true
	return false

func reset_state(
	trans_init: XDUT_MotionTransitionInit,
	state: XDUT_MotionState) -> XDUT_MotionState:

	assert(trans_init != null)
	
	var value = _target.get_indexed(_target_key)
	value = _unwrap(value)
	match typeof(value):
		TYPE_INT:
			if state == null:
				state = XDUT_IntMotionState.new()
			elif state is not XDUT_IntMotionState:
				state = null
		TYPE_FLOAT:
			if state == null:
				state = XDUT_FloatMotionState.new()
			elif state is not XDUT_FloatMotionState:
				state = null
		TYPE_VECTOR2:
			if state == null:
				state = XDUT_Vector2MotionState.new()
			elif state is not XDUT_Vector2MotionState:
				state = null
		TYPE_VECTOR2I:
			if state == null:
				state = XDUT_Vector2iMotionState.new()
			elif state is not XDUT_Vector2iMotionState:
				state = null
		TYPE_VECTOR3:
			if state == null:
				state = XDUT_Vector3MotionState.new()
			elif state is not XDUT_Vector3MotionState:
				state = null
		TYPE_VECTOR3I:
			if state == null:
				state = XDUT_Vector3iMotionState.new()
			elif state is not XDUT_Vector3iMotionState:
				state = null
		TYPE_TRANSFORM2D:
			if state == null:
				state = XDUT_Transform2DMotionState.new()
			elif state is not XDUT_Transform2DMotionState:
				state = null
		TYPE_BASIS:
			if state == null:
				state = XDUT_BasisMotionState.new()
			elif state is not XDUT_BasisMotionState:
				state = null
		TYPE_TRANSFORM3D:
			if state == null:
				state = XDUT_Transform3DMotionState.new()
			elif state is not XDUT_Transform3DMotionState:
				state = null
		TYPE_VECTOR4:
			if state == null:
				state = XDUT_Vector4MotionState.new()
			elif state is not XDUT_Vector4MotionState:
				state = null
		TYPE_VECTOR4I:
			if state == null:
				state = XDUT_Vector4iMotionState.new()
			elif state is not XDUT_Vector4iMotionState:
				state = null
		TYPE_COLOR:
			if state == null:
				state = XDUT_ColorMotionState.new()
			elif state is not XDUT_ColorMotionState:
				state = null
		TYPE_PACKED_INT32_ARRAY:
			if state == null:
				state = XDUT_PackedInt32ArrayMotionState.new(value.size())
			elif state is not XDUT_PackedInt32ArrayMotionState or state.get_element_count() != value.size():
				state = null
		TYPE_PACKED_INT64_ARRAY:
			if state == null:
				state = XDUT_PackedInt64ArrayMotionState.new(value.size())
			elif state is not XDUT_PackedInt64ArrayMotionState or state.get_element_count() != value.size():
				state = null
		TYPE_PACKED_FLOAT32_ARRAY:
			if state == null:
				state = XDUT_PackedFloat32ArrayMotionState.new(value.size())
			elif state is not XDUT_PackedFloat32ArrayMotionState or state.get_element_count() != value.size():
				state = null
		TYPE_PACKED_FLOAT64_ARRAY:
			if state == null:
				state = XDUT_PackedFloat64ArrayMotionState.new(value.size())
			elif state is not XDUT_PackedFloat64ArrayMotionState or state.get_element_count() != value.size():
				state = null
		TYPE_PACKED_VECTOR2_ARRAY:
			if state == null:
				state = XDUT_PackedVector2ArrayMotionState.new(value.size())
			elif state is not XDUT_PackedVector2ArrayMotionState or state.get_element_count() != value.size():
				state = null
		TYPE_PACKED_VECTOR3_ARRAY:
			if state == null:
				state = XDUT_PackedVector3ArrayMotionState.new(value.size())
			elif state is not XDUT_PackedVector3ArrayMotionState or state.get_element_count() != value.size():
				state = null
		TYPE_PACKED_COLOR_ARRAY:
			if state == null:
				state = XDUT_PackedColorArrayMotionState.new(value.size())
			elif state is not XDUT_PackedColorArrayMotionState or state.get_element_count() != value.size():
				state = null
	if state != null:
		state.set_position(value)
	return state

#-------------------------------------------------------------------------------

var _target: Node
var _target_instance_id: int
var _target_name: String
var _target_key: String

static func _unwrap(value: Variant) -> Variant:
	return _unwrap(value.call()) if typeof(value) == TYPE_CALLABLE else value

func _init(
	target: Node,
	target_key: String,
	canonical: Node) -> void:

	super(canonical)

	assert(target != null)
	assert(not target_key.is_empty())
	_target = target
	_target_instance_id = target.get_instance_id()
	_target_name = target.name
	_target_key = target_key
