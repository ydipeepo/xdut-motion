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

func create_state(trans_init: XDUT_MotionTransitionInit) -> XDUT_MotionState:
	assert(trans_init != null)
	
	var state: XDUT_MotionState
	var value = _target.get_indexed(_target_key)
	value = _unwrap(value)
	match typeof(value):
		TYPE_INT:
			state = XDUT_IntMotionState.new()
		TYPE_FLOAT:
			state = XDUT_FloatMotionState.new()
		TYPE_VECTOR2:
			state = XDUT_Vector2MotionState.new()
		TYPE_VECTOR2I:
			state = XDUT_Vector2iMotionState.new()
		TYPE_VECTOR3:
			state = XDUT_Vector3MotionState.new()
		TYPE_VECTOR3I:
			state = XDUT_Vector3iMotionState.new()
		TYPE_TRANSFORM2D:
			state = XDUT_Transform2DMotionState.new()
		TYPE_BASIS:
			state = XDUT_BasisMotionState.new()
		TYPE_TRANSFORM3D:
			state = XDUT_Transform3DMotionState.new()
		TYPE_VECTOR4:
			state = XDUT_Vector4MotionState.new()
		TYPE_VECTOR4I:
			state = XDUT_Vector4iMotionState.new()
		TYPE_COLOR:
			state = XDUT_ColorMotionState.new()
		TYPE_PACKED_INT32_ARRAY:
			state = XDUT_PackedInt32ArrayMotionState.new(value.size())
		TYPE_PACKED_INT64_ARRAY:
			state = XDUT_PackedInt64ArrayMotionState.new(value.size())
		TYPE_PACKED_FLOAT32_ARRAY:
			state = XDUT_PackedFloat32ArrayMotionState.new(value.size())
		TYPE_PACKED_FLOAT64_ARRAY:
			state = XDUT_PackedFloat64ArrayMotionState.new(value.size())
		TYPE_PACKED_VECTOR2_ARRAY:
			state = XDUT_PackedVector2ArrayMotionState.new(value.size())
		TYPE_PACKED_VECTOR3_ARRAY:
			state = XDUT_PackedVector3ArrayMotionState.new(value.size())
		TYPE_PACKED_COLOR_ARRAY:
			state = XDUT_PackedColorArrayMotionState.new(value.size())
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
