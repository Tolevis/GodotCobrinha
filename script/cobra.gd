class_name cobra extends Node2D


var head := Cobrinha.new()
var cobrinhas := [] as Array[Cobrinha]

var curr_direction := Vector2.RIGHT
var next_direction := Vector2.RIGHT

var tween_move: Tween

signal hit(cobrinhas_hit: Cobrinha)

func _ready():
	head.size = Jogo.CELL_SIZE
	head.color = cores.AZUL_ESCURO
	cobrinhas.push_front(head)
	
	hit.connect(_on_hit)
	
	tween_move = create_tween().set_loops()
	tween_move.tween_callback(move).set_delay(.100)


func _process(delta):
	queue_redraw()


func _draw():
	for cobrinha in cobrinhas:
		draw_rect(cobrinha.get_rect(), cobrinha.color)


func _input(event):
	if event.is_action_pressed("move_left") and curr_direction != Vector2.RIGHT:
		next_direction = Vector2.LEFT
	if event.is_action_pressed("move_right") and curr_direction != Vector2.LEFT:
		next_direction = Vector2.RIGHT
	if event.is_action_pressed("move_up") and curr_direction != Vector2.DOWN:
		next_direction = Vector2.UP
	if event.is_action_pressed("move_down") and curr_direction != Vector2.UP:
		next_direction = Vector2.DOWN
		
	# test
	if event.is_action_pressed("grow"): grow()


func move() -> void:
	curr_direction = next_direction
	var next_position = head.curr_position + (curr_direction * Jogo.CELL_SIZE)
	next_position.x = Utils.repeat(next_position.x, Jogo.GRID_SIZE.x)
	next_position.y = Utils.repeat(next_position.y, Jogo.GRID_SIZE.y)
	head.curr_position = next_position

	# mover outra cobrinha
	for i in range(1, cobrinhas.size()):
		cobrinhas[i].curr_position = cobrinhas[i-1].prev_position
	
	# arrumar colisão entre a cobra e as cobrinhas
	for i in range(1, cobrinhas.size()):
		if head.get_rect().intersects((cobrinhas[i].get_rect())):
			hit.emit(cobrinhas[i])
			Jogo.gameover.emit()
			break

func grow() -> void:
	var cobrinha := Cobrinha.new()
	var last_cobrinha := cobrinhas.back() as Cobrinha
	
	cobrinha.curr_position = last_cobrinha.curr_position
	cobrinha.color = cores.AZUL
	cobrinha.size = Jogo.CELL_SIZE
	cobrinhas.push_back(cobrinha)
	
	Jogo.score += 1
	
func _on_hit(mini: Cobrinha) -> void:
	tween_move.kill()

	await get_tree().process_frame

	for Cobrinha in cobrinhas:
		Cobrinha.go_to_prev_position()
