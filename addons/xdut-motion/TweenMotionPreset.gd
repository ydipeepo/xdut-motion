## Tween アニメーションのプリセットを定義するためのリソースです。
class_name TweenMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_TRANS_TYPE := XDUT_TweenMotionTransition.DEFAULT_TRANS_TYPE

const DEFAULT_EASE_TYPE := XDUT_TweenMotionTransition.DEFAULT_EASE_TYPE

const MIN_DURATION := 0.0
const MAX_DURATION := 10.0
const DEFAULT_DURATION := XDUT_TweenMotionTransition.DEFAULT_DURATION

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
	"Back")
var trans_type := DEFAULT_TRANS_TYPE

## アニメーションのイージング関数。
@export_enum(
	"In",
	"Out",
	"In and Out",
	"Out and In")
var ease_type := DEFAULT_EASE_TYPE

## アニメーションの期間。
@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater")
var duration := DEFAULT_DURATION

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
	trans_type := DEFAULT_TRANS_TYPE,
	ease_type := DEFAULT_EASE_TYPE,
	duration := DEFAULT_DURATION,
	delay := DEFAULT_DELAY,
	process := DEFAULT_PROCESS) -> void:

	super(name, delay, process)
	self.trans_type = trans_type
	self.ease_type = ease_type
	self.duration = duration
