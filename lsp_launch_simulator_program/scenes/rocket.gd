extends Node2D  # Or the parent node type

func _ready():
    $GPUParticles2D.emitting = true
