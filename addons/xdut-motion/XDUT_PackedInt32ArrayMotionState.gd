class_name XDUT_PackedInt32ArrayMotionState extends XDUT_PackedFloat32ArrayMotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_position() -> Variant:
	for index: int in get_element_count():
		_exotic_position[index] = int(get_position_at(index))
	return _exotic_position

func get_initial_position() -> Variant:
	for index: int in get_element_count():
		_exotic_initial_position[index] = int(get_position_at(index))
	return _exotic_initial_position

func get_final_position() -> Variant:
	for index: int in get_element_count():
		_exotic_final_position[index] = int(get_position_at(index))
	return _exotic_final_position

#-------------------------------------------------------------------------------

var _exotic_position: PackedInt32Array
var _exotic_initial_position: PackedInt32Array
var _exotic_final_position: PackedInt32Array

func _init(element_count: int) -> void:
	super(element_count)
	_exotic_position.resize(get_element_count())
	_exotic_initial_position.resize(get_element_count())
	_exotic_final_position.resize(get_element_count())
