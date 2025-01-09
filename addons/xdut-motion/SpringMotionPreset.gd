## バネアニメーションのプリセットを定義するためのリソースです。
class_name SpringMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## アニメーションの剛性。
@export_range(XDUT_MotionTransition.EPSILON, 1000.0, 1.0, "or_greater") var stiffness := XDUT_SpringMotionTransition.DEFAULT_STIFFNESS

## アニメーションの減衰。
@export_range(0.0, 1000.0, 1.0, "or_greater") var damping := XDUT_SpringMotionTransition.DEFAULT_DAMPING

## アニメーションの質量。
@export_range(XDUT_MotionTransition.EPSILON, 1000.0, 1.0, "or_greater") var mass := XDUT_SpringMotionTransition.DEFAULT_MASS

## アニメーションを休止させる位置デルタ。
@export_range(XDUT_MotionTransition.EPSILON, 10.0, 0.1, "or_greater") var rest_delta := XDUT_SpringMotionTransition.DEFAULT_REST_DELTA

## アニメーションを休止させる速度。
@export_range(XDUT_MotionTransition.EPSILON, 10.0, 0.1, "or_greater", "units/s") var rest_speed := XDUT_SpringMotionTransition.DEFAULT_REST_SPEED

## アニメーションが過減衰とならないよう制限するかどうか。
@export var limit_overdamping := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING

## アニメーションがオーバーシュートしないよう制限するかどうか。
@export var limit_overshooting := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING

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
	stiffness := XDUT_SpringMotionTransition.DEFAULT_STIFFNESS,
	damping := XDUT_SpringMotionTransition.DEFAULT_DAMPING,
	mass := XDUT_SpringMotionTransition.DEFAULT_MASS,
	rest_delta := XDUT_SpringMotionTransition.DEFAULT_REST_DELTA,
	rest_speed := XDUT_SpringMotionTransition.DEFAULT_REST_SPEED,
	limit_overdamping := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING,
	limit_overshooting := XDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING,
	delay := 0.0,
	process: int = XDUT_MotionTimer.PROCESS_DEFAULT) -> void:

	super(name, delay, process)
	self.stiffness = stiffness
	self.damping = damping
	self.mass = mass
	self.rest_delta = rest_delta
	self.rest_speed = rest_speed
	self.limit_overdamping = limit_overdamping
	self.limit_overshooting = limit_overshooting
