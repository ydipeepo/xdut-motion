class_name XDUT_MethodMotionProcessor extends XDUT_MotionProcessor

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
		_target.call(_target_key, state.get_position())
		return true
	return false

func create_state(trans_init: XDUT_MotionTransitionInit) -> XDUT_MotionState:
	assert(trans_init != null)

	var state: XDUT_MotionState
	var ip = _unwrap(trans_init.initial_position)
	var fp = _unwrap(trans_init.final_position)
	var iv = _unwrap(trans_init.initial_velocity)
	var ip_type := _get_type(typeof(ip))
	var fp_type := _get_type(typeof(fp))
	var iv_type := _get_type(typeof(iv))
	match [ip_type, fp_type, iv_type]:
		[TYPE_FLOAT, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_FLOAT, TYPE_NIL], \
		[TYPE_FLOAT, TYPE_FLOAT, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_FLOAT], \
		[TYPE_FLOAT, TYPE_NIL, TYPE_FLOAT], \
		[TYPE_NIL, TYPE_FLOAT, TYPE_FLOAT], \
		[TYPE_FLOAT, TYPE_FLOAT, TYPE_FLOAT]:
			state = XDUT_FloatMotionState.new()
		[TYPE_VECTOR2, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_VECTOR2, TYPE_NIL], \
		[TYPE_VECTOR2, TYPE_VECTOR2, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_VECTOR2], \
		[TYPE_VECTOR2, TYPE_NIL, TYPE_VECTOR2], \
		[TYPE_NIL, TYPE_VECTOR2, TYPE_VECTOR2], \
		[TYPE_VECTOR2, TYPE_VECTOR2, TYPE_VECTOR2]:
			state = XDUT_Vector2MotionState.new()
		[TYPE_VECTOR3, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_VECTOR3, TYPE_NIL], \
		[TYPE_VECTOR3, TYPE_VECTOR3, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_VECTOR3], \
		[TYPE_VECTOR3, TYPE_NIL, TYPE_VECTOR3], \
		[TYPE_NIL, TYPE_VECTOR3, TYPE_VECTOR3], \
		[TYPE_VECTOR3, TYPE_VECTOR3, TYPE_VECTOR3]:
			state = XDUT_Vector3MotionState.new()
		[TYPE_TRANSFORM2D, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_TRANSFORM2D, TYPE_NIL], \
		[TYPE_TRANSFORM2D, TYPE_TRANSFORM2D, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_TRANSFORM2D], \
		[TYPE_TRANSFORM2D, TYPE_NIL, TYPE_TRANSFORM2D], \
		[TYPE_NIL, TYPE_TRANSFORM2D, TYPE_TRANSFORM2D], \
		[TYPE_TRANSFORM2D, TYPE_TRANSFORM2D, TYPE_TRANSFORM2D]:
			state = XDUT_Transform2DMotionState.new()
		[TYPE_BASIS, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_BASIS, TYPE_NIL], \
		[TYPE_BASIS, TYPE_BASIS, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_BASIS], \
		[TYPE_BASIS, TYPE_NIL, TYPE_BASIS], \
		[TYPE_NIL, TYPE_BASIS, TYPE_BASIS], \
		[TYPE_BASIS, TYPE_BASIS, TYPE_BASIS]:
			state = XDUT_BasisMotionState.new()
		[TYPE_TRANSFORM3D, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_TRANSFORM3D, TYPE_NIL], \
		[TYPE_TRANSFORM3D, TYPE_TRANSFORM3D, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_TRANSFORM3D], \
		[TYPE_TRANSFORM3D, TYPE_NIL, TYPE_TRANSFORM3D], \
		[TYPE_NIL, TYPE_TRANSFORM3D, TYPE_TRANSFORM3D], \
		[TYPE_TRANSFORM3D, TYPE_TRANSFORM3D, TYPE_TRANSFORM3D]:
			state = XDUT_Transform3DMotionState.new()
		[TYPE_VECTOR4, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_VECTOR4, TYPE_NIL], \
		[TYPE_VECTOR4, TYPE_VECTOR4, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_VECTOR4], \
		[TYPE_VECTOR4, TYPE_NIL, TYPE_VECTOR4], \
		[TYPE_NIL, TYPE_VECTOR4, TYPE_VECTOR4], \
		[TYPE_VECTOR4, TYPE_VECTOR4, TYPE_VECTOR4]:
			state = XDUT_Vector4MotionState.new()
		[TYPE_COLOR, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_COLOR, TYPE_NIL], \
		[TYPE_COLOR, TYPE_COLOR, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_COLOR], \
		[TYPE_COLOR, TYPE_NIL, TYPE_COLOR], \
		[TYPE_NIL, TYPE_COLOR, TYPE_COLOR], \
		[TYPE_COLOR, TYPE_COLOR, TYPE_COLOR]:
			state = XDUT_ColorMotionState.new()
		[TYPE_PACKED_FLOAT32_ARRAY, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_PACKED_FLOAT32_ARRAY, TYPE_NIL], \
		[TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_FLOAT32_ARRAY, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_PACKED_FLOAT32_ARRAY], \
		[TYPE_PACKED_FLOAT32_ARRAY, TYPE_NIL, TYPE_PACKED_FLOAT32_ARRAY], \
		[TYPE_NIL, TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_FLOAT32_ARRAY], \
		[TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_FLOAT32_ARRAY]:
			var size = _get_size(ip, fp, iv, ip_type, fp_type, iv_type)
			if size != null:
				state = XDUT_PackedFloat32ArrayMotionState.new(size)
		[TYPE_PACKED_FLOAT64_ARRAY, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_PACKED_FLOAT64_ARRAY, TYPE_NIL], \
		[TYPE_PACKED_FLOAT64_ARRAY, TYPE_PACKED_FLOAT64_ARRAY, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_PACKED_FLOAT64_ARRAY], \
		[TYPE_PACKED_FLOAT64_ARRAY, TYPE_NIL, TYPE_PACKED_FLOAT64_ARRAY], \
		[TYPE_NIL, TYPE_PACKED_FLOAT64_ARRAY, TYPE_PACKED_FLOAT64_ARRAY], \
		[TYPE_PACKED_FLOAT64_ARRAY, TYPE_PACKED_FLOAT64_ARRAY, TYPE_PACKED_FLOAT64_ARRAY]:
			var size = _get_size(ip, fp, iv, ip_type, fp_type, iv_type)
			if size != null:
				state = XDUT_PackedFloat32ArrayMotionState.new(size)
		[TYPE_PACKED_VECTOR2_ARRAY, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_PACKED_VECTOR2_ARRAY, TYPE_NIL], \
		[TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR2_ARRAY, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_PACKED_VECTOR2_ARRAY], \
		[TYPE_PACKED_VECTOR2_ARRAY, TYPE_NIL, TYPE_PACKED_VECTOR2_ARRAY], \
		[TYPE_NIL, TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR2_ARRAY], \
		[TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR2_ARRAY]:
			var size = _get_size(ip, fp, iv, ip_type, fp_type, iv_type)
			if size != null:
				state = XDUT_PackedVector2ArrayMotionState.new(size)
		[TYPE_PACKED_VECTOR3_ARRAY, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_PACKED_VECTOR3_ARRAY, TYPE_NIL], \
		[TYPE_PACKED_VECTOR3_ARRAY, TYPE_PACKED_VECTOR3_ARRAY, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_PACKED_VECTOR3_ARRAY], \
		[TYPE_PACKED_VECTOR3_ARRAY, TYPE_NIL, TYPE_PACKED_VECTOR3_ARRAY], \
		[TYPE_NIL, TYPE_PACKED_VECTOR3_ARRAY, TYPE_PACKED_VECTOR3_ARRAY], \
		[TYPE_PACKED_VECTOR3_ARRAY, TYPE_PACKED_VECTOR3_ARRAY, TYPE_PACKED_VECTOR3_ARRAY]:
			var size = _get_size(ip, fp, iv, ip_type, fp_type, iv_type)
			if size != null:
				state = XDUT_PackedVector3ArrayMotionState.new(size)
		[TYPE_PACKED_COLOR_ARRAY, TYPE_NIL, TYPE_NIL], \
		[TYPE_NIL, TYPE_PACKED_COLOR_ARRAY, TYPE_NIL], \
		[TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_COLOR_ARRAY, TYPE_NIL], \
		[TYPE_NIL, TYPE_NIL, TYPE_PACKED_COLOR_ARRAY], \
		[TYPE_PACKED_COLOR_ARRAY, TYPE_NIL, TYPE_PACKED_COLOR_ARRAY], \
		[TYPE_NIL, TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_COLOR_ARRAY], \
		[TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_COLOR_ARRAY]:
			var size = _get_size(ip, fp, iv, ip_type, fp_type, iv_type)
			if size != null:
				state = XDUT_PackedColorArrayMotionState.new(size)
	if state != null:
		if ip != null:
			state.set_position(ip)
		#if fp != null:
		#	state.set_position(fp)
		#if iv != null:
		#	state.set_velocity(iv)
	return state

#-------------------------------------------------------------------------------

var _target: Node
var _target_instance_id: int
var _target_name: String
var _target_key: String

static func _unwrap(value: Variant) -> Variant:
	return _unwrap(value.call()) if typeof(value) == TYPE_CALLABLE else value

static func _get_type(type: int) -> int:
	match type:
		TYPE_INT:
			return TYPE_FLOAT
		TYPE_VECTOR2I:
			return TYPE_VECTOR2
		TYPE_VECTOR3I:
			return TYPE_VECTOR3
		TYPE_VECTOR4I:
			return TYPE_VECTOR4
		TYPE_PACKED_INT32_ARRAY:
			return TYPE_PACKED_FLOAT32_ARRAY
		TYPE_PACKED_INT64_ARRAY:
			return TYPE_PACKED_FLOAT64_ARRAY
		_:
			return type

static func _get_size(
	ip: Variant,
	fp: Variant,
	iv: Variant,
	ip_type: int,
	fp_type: int,
	iv_type: int) -> Variant:

	if ip_type != TYPE_NIL:
		var ip_size: int = ip.size()
		if fp_type != TYPE_NIL:
			var fp_size: int = fp.size()
			if iv_type != TYPE_NIL:
				var iv_size: int = iv.size()
				if ip_size == fp_size and ip_size == iv_type:
					return ip_size
				return null
			if ip_size == fp_size:
				return ip_size
			return null
		if iv_type != TYPE_NIL:
			var iv_size: int = iv.size()
			if ip_size == iv_size:
				return ip_size
			return null
		return ip_size
	if fp_type != TYPE_NIL:
		var final_position_size: int = fp.size()
		if iv_type != TYPE_NIL:
			var iv_size: int = iv.size()
			if final_position_size == iv_size:
				return final_position_size
			return null
		return final_position_size
	if iv_type != TYPE_NIL:
		var iv_size: int = iv.size()
		return iv_size
	return null

func _init(
	target: Node,
	target_key: StringName,
	canonical: Node) -> void:

	super(canonical)

	assert(target != null)
	assert(not target_key.is_empty())
	_target = target
	_target_instance_id = target.get_instance_id()
	_target_name = target.name
	_target_key = target_key
