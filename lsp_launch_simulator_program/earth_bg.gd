extends ParallaxBackground
@export var max_scroll_speed: float = 100.0
var scroll_speed: float = 5.0
var elapsed_time: float = 0.0
@export var DURATION: float = 10.0

func _ready() -> void:
    pass 

func _process(delta: float) -> void:
    # Incrémente le temps écoulé avec le temps de la frame actuelle.
    elapsed_time += delta
    
    # Si le temps écoulé est inférieur à la durée spécifiée,
    #vitesse de défilement de 5.0 à max_scroll_speed
    if elapsed_time < DURATION:
		#linear interpolation(from, to, weight)
        scroll_speed = lerp(5.0, max_scroll_speed, elapsed_time / DURATION)
    
    scroll_offset.y += scroll_speed * delta