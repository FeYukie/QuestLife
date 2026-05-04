extends CharacterBody2D

const speed = 30
var is_roaming = true
var is_chatting = false

# Carregue o recurso de diálogo aqui para facilitar o uso
@export var dialogo_recurso: DialogueResource = preload("res://dialogue/dialogue1.dialogue")
@export var dialogo_titulo: String = "start"

func iniciar_dialogo():
	if not is_chatting:
		is_chatting = true
		is_roaming = false
		
		# Usa a função do singleton global do Dialogue Manager
		DialogueManager.show_dialogue_balloon(dialogo_recurso, dialogo_titulo)
		
		# Opcional: Conectar sinal para saber quando o diálogo termina
		DialogueManager.dialogue_ended.connect(_ao_terminar_dialogo, CONNECT_ONE_SHOT)

func _ao_terminar_dialogo(_resource):
	is_chatting = false
	is_roaming = true

# Sinais da Area2D (Actionable)
func _on_actionable_body_entered(body: Node2D) -> void:
	print("Colidiu com: ", body.name) # Isso vai aparecer no console lá embaixo
	if body.has_method("jogador"):
		body.pode_interagir = true
		body.npc_proximo = self
		print("Jogador detectado!")

func _on_actionable_body_exited(body: Node2D) -> void:
	if body.has_method("jogador"):
		body.pode_interagir = false
		body.npc_proximo = null
