class_name Food

var position := Vector2()
var size := Jogo.CELL_SIZE
var cor := cores.AZUL_CEU


func get_rect() -> Rect2:
	return Rect2(position, size)
