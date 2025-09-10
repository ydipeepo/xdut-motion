## バネアニメーションのプリセットを定義するためのリソースです。
class_name SpringMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_STIFFNESS := XDUT_MotionTransition.EPSILON
const MAX_STIFFNESS := 1000.0
const DEFAULT_STIFFNESS := XDUT_SpringMotionTransition.DEFAULT_STIFFNESS

const MIN_DAMPING := 0.0
const MAX_DAMPING := 1000.0
const DEFAULT_DAMPING := XDUT_SpringMotionTransition.DEFAULT_DAMPING

const MIN_MASS := XDUT_MotionTransition.EPSILON
const MAX_MASS := 1000.0
const DEFAULT_MASS := XDUT_SpringMotionTransition.DEFAULT_MASS

const MIN_REST_DELTA := XDUT_MotionTransition.EPSILON
const MAX_REST_DELTA := 10.0
const DEFAULT_REST_DELTA := XDUT_SpringMotionTransition.DEFAULT_REST_DELTA

const MIN_REST_SPEED := XDUT_MotionTransition.EPSILON
const MAX_REST_SPEED := 10.0
const DEFAULT_REST_SPEED := XDUT_SpringMotionTransition.DEFAULT_REST_SPEED

const DEFAULT_LIMIT_OVERDAMPING := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING

const DEFAULT_LIMIT_OVERSHOOTING := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## アニメーションの剛性。
@export_range(MIN_STIFFNESS, MAX_STIFFNESS, 1.0, "or_greater")
var stiffness := DEFAULT_STIFFNESS

## アニメーションの減衰。
@export_range(MIN_DAMPING, MAX_DAMPING, 1.0, "or_greater")
var damping := DEFAULT_DAMPING

## アニメーションの質量。
@export_range(MIN_MASS, MAX_MASS, 1.0, "or_greater")
var mass := DEFAULT_MASS

## アニメーションを休止させる位置デルタ。
@export_range(MIN_REST_DELTA, MAX_REST_DELTA, 0.001, "or_greater")
var rest_delta := DEFAULT_REST_DELTA

## アニメーションを休止させる速度。
@export_range(MIN_REST_SPEED, MAX_REST_SPEED, 0.001, "or_greater", "units/s")
var rest_speed := DEFAULT_REST_SPEED

## アニメーションが過減衰とならないよう制限するかどうか。
@export
var limit_overdamping := DEFAULT_LIMIT_OVERDAMPING

## アニメーションがオーバーシュートしないよう制限するかどうか。
@export
var limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return trans_init is XDUT_SpringMotionTransitionInit

func apply(trans_init: XDUT_MotionTransitionInit) -> void:
	super(trans_init)
	trans_init.stiffness = stiffness
	trans_init.damping = damping
	trans_init.mass = mass
	trans_init.rest_delta = rest_delta
	trans_init.rest_speed = rest_speed
	trans_init.limit_overdamping = limit_overdamping
	trans_init.limit_overshooting = limit_overshooting

#-------------------------------------------------------------------------------

func _init(
	name := "",
	stiffness := DEFAULT_STIFFNESS,
	damping := DEFAULT_DAMPING,
	mass := DEFAULT_MASS,
	rest_delta := DEFAULT_REST_DELTA,
	rest_speed := DEFAULT_REST_SPEED,
	limit_overdamping := DEFAULT_LIMIT_OVERDAMPING,
	limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING,
	delay := DEFAULT_DELAY,
	process := DEFAULT_PROCESS) -> void:

	super(name, delay, process)
	self.stiffness = stiffness
	self.damping = damping
	self.mass = mass
	self.rest_delta = rest_delta
	self.rest_speed = rest_speed
	self.limit_overdamping = limit_overdamping
	self.limit_overshooting = limit_overshooting
