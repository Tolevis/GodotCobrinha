extends Node2D



func _ready() -> void:
	pass 


func _process(_delta) -> void:
	pass


func _draw() -> void:
	# desenho do fundo
	draw_rect(Rect2(0, 0, Jogo.GRID_SIZE.x, Jogo.GRID_SIZE.y), cores.BRANCO)
	
	# desenho das linhas
	for i in Jogo.CELLS_AMOUNT.x:
		var from := Vector2(i * Jogo.CELL_SIZE.x, 0)
		var to := Vector2(from.x, Jogo.GRID_SIZE.y)
		draw_line(from, to, cores.CINZA)
	
	# desenho horizontal das linhas
	for i in Jogo.CELLS_AMOUNT.y:
		var from := Vector2(0, Jogo.CELL_SIZE.y * i)
		var to := Vector2(Jogo.GRID_SIZE.x, from.y)
		draw_line(from, to, cores.CINZA)
		
		
		
		
