extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.removeLife(999)
