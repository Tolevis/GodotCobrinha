extends Node2D


var food := Food.new()

@onready var cobra := %cobra as cobra


func _ready() -> void:
	spawn_food()


func _draw():
	draw_rect(food.get_rect(), food.cor)


func _process(delta: float) -> void:
	queue_redraw()

	# checar a colisão entre a comida e cobra
	if food.get_rect().intersects(cobra.head.get_rect()):
		cobra.grow()
		spawn_food()

func spawn_food() -> void:
	var is_on_occupied_position = true
	
	while is_on_occupied_position:
		is_on_occupied_position = false
		var random_position = Vector2()
		random_position.x = randi_range(0, Jogo.GRID_SIZE.x - Jogo.CELL_SIZE.x)
		random_position.y = randi_range(0, Jogo.GRID_SIZE.y - Jogo.CELL_SIZE.y)
		food.position = random_position.snapped(Jogo.CELL_SIZE)

		# Verificar se a comida está em uma posição ocupada pela cobra
		for cobrinha in cobra.cobrinhas:
			if food.get_rect().intersects(cobrinha.get_rect()):
				is_on_occupied_position = true
				break  # Se encontrarmos uma colisão, saímos do loop
