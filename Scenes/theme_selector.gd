extends CanvasLayer
var screen = 0
var type


func _on_regular_abc_list_item_activated(index: int) -> void:
	if $RegularABCList.get_item_text(index) == "Poached Eggs 1":
		get_parent().pick_theme("Poached Eggs")
	elif $RegularABCList.get_item_text(index) == "Poached Eggs 3":
		get_parent().pick_theme("Poached Eggs 3")
	else:
		get_parent().pick_theme($RegularABCList.get_item_text(index))
	hide()


func _on_regular_ab_se_list_item_activated(index: int) -> void:
	get_parent().pick_theme($RegularABSeList.get_item_text(index))
	hide()


func _on_back_button_button_down() -> void:
	$ButtonBack.play()
	if screen == 0:
		hide()
		if get_parent().name == "Editor":
			get_parent().screen = 4
	else:
		for list in get_children():
			if list is ItemList:
				list.hide()
	if screen == 1:
		$TypeSelect.show()
		screen = 0
	elif screen == 2:
		$GameSelect.show()
		screen = 1


func _on_type_select_item_activated(index: int) -> void:
	type = index
	$GameSelect.show()
	$TypeSelect.hide()
	screen = 1
	$ButtonSound.play()
	if type == 0:
		$GameSelect.set_item_disabled(0, false)
		$GameSelect.set_item_disabled(1, false)
		$GameSelect.set_item_disabled(2, false)
		$GameSelect.set_item_disabled(3, true)
		$GameSelect.set_item_disabled(4, true)
		$GameSelect.set_item_disabled(5, true)
		$GameSelect.set_item_disabled(6, true)
		$GameSelect.set_item_disabled(7, true)
		$GameSelect.set_item_disabled(8, true)
		$GameSelect.set_item_disabled(9, true)
		$GameSelect.set_item_disabled(10, true)
		$GameSelect.set_item_disabled(11, false)
		$GameSelect.set_item_disabled(12, true)
	if type == 1:
		$GameSelect.set_item_disabled(0, true)
		$GameSelect.set_item_disabled(1, false)
		$GameSelect.set_item_disabled(2, true)
		$GameSelect.set_item_disabled(3, true)
		$GameSelect.set_item_disabled(4, true)
		$GameSelect.set_item_disabled(5, true)
		$GameSelect.set_item_disabled(6, true)
		$GameSelect.set_item_disabled(7, true)
		$GameSelect.set_item_disabled(8, true)
		$GameSelect.set_item_disabled(9, true)
		$GameSelect.set_item_disabled(10, true)
		$GameSelect.set_item_disabled(11, true)
		$GameSelect.set_item_disabled(12, true)


func _on_game_select_item_activated(index: int) -> void:
	$GameSelect.hide()
	$ButtonSound.play()
	screen = 2
	if type == 0:
		if $GameSelect.get_item_text(index) == "Classic":
			$RegularABCList.show()
		elif $GameSelect.get_item_text(index) == "Seasons":
			$RegularABSeList.show()
		elif $GameSelect.get_item_text(index) == "Rio":
			$RegularABRioList.show()
		elif $GameSelect.get_item_text(index) == "Other":
			$RegularOtherList.show()
	elif type == 1:
		if $GameSelect.get_item_text(index) == "Seasons":
			$NoGroundABSeList.show()

func appear():
	show()
	screen = 0
	for list in get_children():
		if list is ItemList:
			list.hide()
	$TypeSelect.show()


func _on_no_ground_ab_se_list_item_activated(index: int) -> void:
	if $NoGroundABSeList.get_item_text(index) == "South Hamerica":
		get_parent().pick_theme("South Hamerica-NG")
	else:
		get_parent().pick_theme($NoGroundABSeList.get_item_text(index))
	hide()


func _on_regular_other_list_item_activated(index: int) -> void:
	get_parent().pick_theme($RegularOtherList.get_item_text(index))
	hide()


func _on_regular_ab_rio_list_item_activated(index: int) -> void:
	get_parent().pick_theme($RegularABRioList.get_item_text(index))
	hide()
