extends Node2D

# Declare the ParallaxBackground nodes
@onready var earth_bg = $EarthBG
@onready var space_bg = $SpaceBG
@onready var timer = $Timer

var fading = false
var fade_duration = 3.0  # Duration of the fade in seconds
var fade_elapsed = 0.0

func _ready():
    # Make sure the space background is hidden and transparent at the start
    space_bg.visible = true
    var sprites = get_all_sprites(space_bg)
    for sprite in sprites:
        sprite.modulate.a = 0.0  # Start fully transparent
    
    # Connect the timeout signal if not connected in the editor
    if not timer.is_connected("timeout", Callable(self, "_on_Timer_timeout")):
        timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
    
    # Start the timer
    timer.start()

func _on_Timer_timeout() -> void:
    # Start fading out EarthBG and fading in SpaceBG simultaneously
    print("Timer finished! Starting transition...")
    fading = true
    fade_elapsed = 0.0

func _process(delta: float) -> void:
    if fading:
        fade_elapsed += delta
        var progress = fade_elapsed / fade_duration
        if progress >= 1.0:
            progress = 1.0
            fading = false
        
        # Fade out EarthBG
        var earth_sprites = get_all_sprites(earth_bg)
        for sprite in earth_sprites:
            sprite.modulate.a = 1.0 - progress
        
        # Fade in SpaceBG
        var space_sprites = get_all_sprites(space_bg)
        for sprite in space_sprites:
            sprite.modulate.a = progress

# Helper function to get all Sprite2D nodes recursively
func get_all_sprites(node: Node) -> Array:
    var sprites = []
    if node is Sprite2D:
        sprites.append(node)
    for child in node.get_children():
        sprites.append_array(get_all_sprites(child))
    return sprites
    
