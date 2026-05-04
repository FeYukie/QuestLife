extends CharacterBody2D

@export var velocidade_maxima = 300.0
@export var aceleracao = 1500.0
@export var atrito = 1200.0
@onready var animation: AnimationPlayer = $AnimationPlayer
var pode_interagir = false
var npc_proximo = null

func _process(delta):
	if pode_interagir and Input.is_action_just_pressed("chat"):
		show_hint("Pressione C para conversar")
		if npc_proximo:
			iniciar_dialogo(npc_proximo)

func iniciar_dialogo(npc):
	npc.iniciar_dialogo()
	
# Função para que outros scripts identifiquem que este é o jogador
func jogador():
	pass
	
func _physics_process(delta):
	# 1. PEGAR A DIREÇÃO DO INPUT
	# Retorna um Vector2 indicando para onde as teclas apontam
	var direcao = Input.get_vector("esquerda", "direita", "cima", "baixo")
	
	# 2. APLICAR MOVIMENTO (Aceleração e Atrito)
	if direcao != Vector2.ZERO:
		# Se houver input, acelera em direção à velocidade máxima
		velocity = velocity.move_toward(direcao * velocidade_maxima, aceleracao * delta)
	else:
		# Se não houver input, aplica atrito até parar
		velocity = velocity.move_toward(Vector2.ZERO, atrito * delta)



	# 4. EXECUTAR O MOVIMENTO
	move_and_slide()
	
