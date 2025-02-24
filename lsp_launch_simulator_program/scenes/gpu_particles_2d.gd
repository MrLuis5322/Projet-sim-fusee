extends GPUParticles2D

# Initial gravity value
@export var gravity_y = 5
# Speed of increase
@export var gravity_increment = 10.0


func _process(delta):
	# Gradually increase the Y gravity over time
	gravity_y += gravity_increment * delta
	# Apply the updated gravity to the particles
	if process_material is ParticleProcessMaterial:
		process_material.gravity.y = gravity_y
