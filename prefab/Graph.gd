extends Panel

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(1, 3) var dimension: int = 2
@export var magnitude: float = 30.0

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func add_frame(value: Variant) -> void:
	match dimension:
		1:
			assert(typeof(value) == TYPE_FLOAT)
			_x_array.push_back(value)
		2:
			assert(typeof(value) == TYPE_VECTOR2)
			_x_array.push_back(value.x)
			_y_array.push_back(value.y)
		3:
			assert(typeof(value) == TYPE_VECTOR3)
			_x_array.push_back(value.x)
			_y_array.push_back(value.y)
			_z_array.push_back(value.z)

	while size.x < _x_array.size():
		_x_array.pop_front()
	while size.x < _y_array.size():
		_y_array.pop_front()
	while size.x < _z_array.size():
		_z_array.pop_front()

#-------------------------------------------------------------------------------

var _x_array: Array[float]
var _y_array: Array[float]
var _z_array: Array[float]

func _ready() -> void:
	match dimension:
		1:
			%Plot_1.visible = true
		2:
			%Plot_1.visible = true
			%Plot_2.visible = true
		3:
			%Plot_1.visible = true
			%Plot_2.visible = true
			%Plot_3.visible = true

func _process(_delta: float) -> void:
	%Plot_1.position.y = size.y / 2.0
	%Plot_2.position.y = size.y / 2.0
	%Plot_3.position.y = size.y / 2.0

	match dimension:
		1:
			var x_points := PackedVector2Array()
			var x := 0
			for y: float in _x_array:
				x_points.push_back(Vector2(x, y * magnitude))
				x += 1
			%Plot_1.points = x_points
		2:
			var x_points := PackedVector2Array()
			var y_points := PackedVector2Array()
			var x := 0
			for y: float in _x_array:
				x_points.push_back(Vector2(x, y * magnitude))
				x += 1
			x = 0
			for y: float in _y_array:
				y_points.push_back(Vector2(x, y * magnitude))
				x += 1
			%Plot_1.points = x_points
			%Plot_2.points = y_points
		3:
			var x_points := PackedVector2Array()
			var y_points := PackedVector2Array()
			var z_points := PackedVector2Array()
			var x := 0
			for y: float in _x_array:
				x_points.push_back(Vector2(x, y * magnitude))
				x += 1
			x = 0
			for y: float in _y_array:
				y_points.push_back(Vector2(x, y * magnitude))
				x += 1
			x = 0
			for y: float in _z_array:
				z_points.push_back(Vector2(x, y * magnitude))
				x += 1
			%Plot_1.points = x_points
			%Plot_2.points = y_points
			%Plot_3.points = z_points
