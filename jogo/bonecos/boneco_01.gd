extends CharacterBody2D

@export var velocidade_maxima = 300.0
@export var aceleracao = 1500.0
@export var atrito = 1200.0
@onready var animation: AnimationPlayer = $AnimationPlayer
var pode_interagir = false
var npc_proximo = null

func _process(delta):
	if pode_interagir and Input.is_action_just_pressed("chat"):
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
	
# --- SISTEMA DE VIDAS ---
var vidas = 3

func _ready():
	add_to_group("player")
	# Supondo que o masculino comece no frame 0 e o feminino no frame 8 (segunda linha)
	if Global.genero_escolhido == "feminino":
		$Sprite2D.frame = 8
	else:
		$Sprite2D.frame = 0

# --- FUNÇÕES DE LÓGICA DO JOGO ---

func perder_vida():
	vidas -= 1
	if vidas <= 0:
		morrer()

func morrer():
	# 1. Buscamos o nó pelo nome exato que está na sua imagem
	# Usar o grupo ainda é a forma mais segura de evitar erro de caminho
	var aviso = get_tree().get_first_node_in_group("ui_morte")
	
	if aviso:
		# Se o grupo estiver no nó 'LabelMorte', mostramos ele
		aviso.show() 
		# Se o nó 'Mensag' for o que tem o texto, garantimos que ele apareça
		if aviso.has_node("Mensag"):
			aviso.get_node("Mensag").show()
	
	# 2. Trava o mundo para dar destaque à mensagem
	get_tree().paused = true
	
	# 3. Espera os 2 segundos (importante: o 'true' final permite rodar na pausa)
	await get_tree().create_timer(2.0, true).timeout
	
	# 4. Destrava e volta para o menu principal
	get_tree().paused = false
	get_tree().change_scene_to_file("res://title_screen/title_screen.tscn")
