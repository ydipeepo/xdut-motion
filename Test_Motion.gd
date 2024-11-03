extends MarginContainer

#-------------------------------------------------------------------------------

static func _rand() -> float:
	return randf_range(-PI, PI)

static func _rand_vector2() -> Vector2:
	return Vector2(_rand(), _rand())

static func _rand_vector3() -> Vector3:
	return Vector3(_rand(), _rand(), _rand())

func _process(_delta: float) -> void:
	%Graph_3D.add_frame(%Cube.rotation)
	%Graph_2D.add_frame(%Square.rotation)

func _on_3d_spring_pressed() -> void:
	var expr := Motion.spring(%Cube, "rotation").to(_rand_vector3())
	match %Spring_3D/Preset.selected:
		0: expr.preset("standard")
		1: expr.preset("gentle")
		2: expr.preset("wobbly")
		3: expr.preset("stiff")
		4: expr.preset("slow")
		5: expr.preset("molasses")
		6: expr.preset("custom")

func _on_3d_tween_pressed() -> void:
	var expr := Motion.tween(%Cube, "rotation").to(_rand_vector3())
	match %Tween_3D/Trans.selected:
		0: expr.linear()
		1: expr.quad()
		2: expr.cubic()
		3: expr.quart()
		4: expr.quint()
		5: expr.sine()
		6: expr.expo()
		7: expr.circ()
		8: expr.elastic()
		9: expr.back()
		10: expr.bounce()
	match %Tween_3D/Ease.selected:
		0: expr.in_()
		1: expr.out()
		2: expr.in_out()
		3: expr.out_in()

func _on_3d_glide_pressed() -> void:
	var expr := Motion.glide(%Cube, "rotation")
	match %Glide_3D/Prefer.selected:
		0: expr.prefer_velocity()
		1: expr.prefer_position().to(0.0)

func _on_3d_cancel_pressed() -> void:
	Motion.cancel(%Cube, "rotation")

func _on_2d_spring_pressed() -> void:
	var expr := Motion.spring(%Square, "rotation").to(_rand())
	match %Spring_2D/Preset.selected:
		0: expr.preset("standard")
		1: expr.preset("gentle")
		2: expr.preset("wobbly")
		3: expr.preset("stiff")
		4: expr.preset("slow")
		5: expr.preset("molasses")
		6: expr.preset("custom")

func _on_2d_tween_pressed() -> void:
	var expr := Motion.tween(%Square, "rotation").to(_rand())
	match %Tween_2D/Trans.selected:
		0: expr.linear()
		1: expr.quad()
		2: expr.cubic()
		3: expr.quart()
		4: expr.quint()
		5: expr.sine()
		6: expr.expo()
		7: expr.circ()
		8: expr.elastic()
		9: expr.back()
		10: expr.bounce()
	match %Tween_2D/Ease.selected:
		0: expr.in_()
		1: expr.out()
		2: expr.in_out()
		3: expr.out_in()

func _on_2d_glide_pressed() -> void:
	var expr := Motion.glide(%Square, "rotation")
	match %Glide_2D/Prefer.selected:
		0: expr.prefer_velocity()
		1: expr.prefer_position().to(0.0)

func _on_2d_cancel_pressed() -> void:
	Motion.cancel(%Square, "rotation")
