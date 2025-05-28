## Tween アニメーションのプリセットを定義するためのリソースです。
class_name TweenMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## アニメーションのトランジション関数。
@export_enum(
	"Linear",
	"Sine",
	"Quint",
	"Quart",
	"Quad",
	"Expo",
	"Elastic",
	"Cubic",
	"Circ",
	"Bounce",
	"Back") var trans_type: int = XDUT_TweenMotionTransition.DEFAULT_TRANS_TYPE

## アニメーションのイージング関数。
@export_enum(
	"In",
	"Out",
	"In and Out",
	"Out and In") var ease_type: int = XDUT_TweenMotionTransition.DEFAULT_EASE_TYPE

## アニメーションの期間。
@export_range(0.0, 10.0, 0.1, "or_greater") var duration := XDUT_TweenMotionTransition.DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return trans_init is XDUT_TweenMotionTransitionInit

func apply(trans_init: XDUT_MotionTransitionInit) -> void:
	super(trans_init)
	trans_init.ease_type = ease_type
	trans_init.trans_type = trans_type
	trans_init.duration = duration

#-------------------------------------------------------------------------------

func _init(
	name := "",
	trans_type: int = XDUT_TweenMotionTransition.DEFAULT_TRANS_TYPE,
	ease_type: int = XDUT_TweenMotionTransition.DEFAULT_EASE_TYPE,
	duration := XDUT_TweenMotionTransition.DEFAULT_DURATION,
	delay := 0.0,
	process: int = XDUT_MotionTimer.PROCESS_DEFAULT) -> void:

	super(name, delay, process)
	self.trans_type = trans_type
	self.ease_type = ease_type
	self.duration = duration
