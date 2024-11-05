extends Node2D


var hit_spot := Rect2(Vector2.ZERO, Jogo.CELL_SIZE)
var hit_color := Color.TRANSPARENT

@onready var cobra := %cobra as cobra


func _ready() -> void:
	cobra.hit.connect(_on_snake_hit)


func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_rect(hit_spot, hit_color)
	
func _on_snake_hit(cobrinha_hit: Cobrinha) -> void:
	hit_spot.position = Vector2(cobrinha_hit.curr_position)
	
	var tween_pulse = create_tween().set_trans(Tween.TRANS_CIRC).set_loops()
	tween_pulse.tween_property(self, "hit_color", cores.VERMELHO, .55).set_ease(Tween.EASE_OUT)
	tween_pulse.tween_property(self, "hit_color", Color.TRANSPARENT, .55).set_ease(Tween.EASE_IN).set_delay(.1)
