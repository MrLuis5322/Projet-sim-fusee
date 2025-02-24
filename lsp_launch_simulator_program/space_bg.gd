extends ParallaxBackground

@export var scroll_speed: float = 200


var transition_started: bool = false

func _ready():
    pass

func _process(delta):
    scroll_offset.y += scroll_speed * delta
  