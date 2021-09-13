extends Panel

func _ready():
	for i in [2, 3]:
		for j in range(5):
			$Slots.get_node("Slot" + str(j) + str(i)).set_disabled(false)
