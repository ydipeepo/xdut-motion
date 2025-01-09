## キャンセルのプリセットを定義するためのリソースです。
class_name CancelMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func can_apply(trans_init: XDUT_MotionTransitionInit) -> bool:
	return trans_init is XDUT_CancelMotionTransitionInit
