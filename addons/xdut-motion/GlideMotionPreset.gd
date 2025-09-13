## 滑走アニメーションのプリセットを定義するためのリソースです。
class_name GlideMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_POWER := XDUT_MotionTransition.EPSILON
const MAX_POWER := 10.0
const DEFAULT_POWER := XDUT_GlideMotionTransition.DEFAULT_POWER

const MIN_TIME_CONSTANT := 0.0
const MAX_TIME_CONSTANT := 10.0
const DEFAULT_TIME_CONSTANT := XDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT

const MIN_REST_DELTA := XDUT_MotionTransition.EPSILON
const MAX_REST_DELTA := 10.0
const DEFAULT_REST_DELTA := XDUT_GlideMotionTransition.DEFAULT_REST_DELTA

const DEFAULT_PREFER := XDUT_GlideMotionTransition.DEFAULT_PREFER

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## アニメーションの崩壊定数。
@export_range(MIN_POWER, MAX_POWER, 0.1, "or_greater")
var power := DEFAULT_POWER

## アニメーションの時定数。
@export_range(MIN_TIME_CONSTANT, MAX_TIME_CONSTANT, 0.1, "or_greater")
var time_constant := DEFAULT_TIME_CONSTANT

## アニメーションを休止させる位置デルタ。
@export_range(MIN_REST_DELTA, MAX_REST_DELTA, 0.001, "or_greater")
var rest_delta := DEFAULT_REST_DELTA

## アニメーションで速度を重視するか位置を重視するか。
@export_enum("Velocity", "Position")
var prefer := DEFAULT_PREFER

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return trans_init is XDUT_CancelMotionTransitionInit

func apply(trans_init: XDUT_MotionTransitionInit) -> void:
	super(trans_init)
	trans_init.power = power
	trans_init.time_constant = time_constant
	trans_init.rest_delta = rest_delta
	trans_init.prefer = prefer

#-------------------------------------------------------------------------------

func _init(
	name := "",
	power := DEFAULT_POWER,
	time_constant := DEFAULT_TIME_CONSTANT,
	rest_delta := DEFAULT_REST_DELTA,
	prefer := DEFAULT_PREFER,
	delay := DEFAULT_DELAY,
	process := DEFAULT_PROCESS) -> void:

	super(name, delay, process)
	self.power = power
	self.time_constant = time_constant
	self.rest_delta = rest_delta
	self.prefer = prefer
