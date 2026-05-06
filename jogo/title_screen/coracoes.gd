extends CanvasLayer

var coracoes : Array[ CoracaoGUI ] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in $Control/HFlowContainer.get_children():
		if child is CoracaoGUI:
			coracoes.append( child )
			child.visible = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_hp( _hp: int, _max_hp: int) -> void:
	update_max_hp( _max_hp )
	for i in _max_hp:
		update_heart( i, _hp )
		pass
	pass

func update_heart( _index : int, _hp : int ) -> void:
	var _value = int = clampi( _hp - +_index * 2, 0, 2 )
	coracoes[ _index ].value = _value
	
func update_max_hp( _max_hp: int) -> void:
	var _heart_count : int = roundi( _max_hp * 0.5 )
	for i in coracoes.size():
		if i < _heart_count:
			coracoes[i].visible = true
		else:
			coracoes[i].visible = false
	pass
