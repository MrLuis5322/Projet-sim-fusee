extends Sprite2D

func _ready():
    # Charger l'image de la fenêtre
    self.texture = preload("res://zImages/Window.jpeg") 
    
    # Créer un shader pour manipuler la couleur et l'opacité de la fenêtre
    var shader_code = """
        shader_type canvas_item;

        uniform vec4 window_color : hint_color;  // Couleur de la vitre
        uniform float window_opacity : hint_range(0.0, 1.0) = 0.5;  // Opacité de la fenêtre (0 à 1)
        uniform float distortion_amount : hint_range(0.0, 0.1) = 0.02;  // Quantité de distorsion
        uniform float reflection_amount : hint_range(0.0, 1.0) = 0.3;  // Quantité de réflexion

        void fragment() {
            vec2 uv = UV;
            uv += (texture(TEXTURE, uv).rg - 0.5) * distortion_amount;  // Ajouter une légère distorsion
            vec4 texColor = texture(TEXTURE, uv);
            
            // Appliquer la couleur de la fenêtre (simule une vitre)
            vec4 windowColor = texColor * window_color * window_opacity;
            
            // Ajouter un effet de réflexion
            vec2 reflection_uv = vec2(UV.x, 1.0 - UV.y);
            vec4 reflectionColor = texture(TEXTURE, reflection_uv) * reflection_amount;
            
            COLOR = windowColor + reflectionColor;  // Combiner la couleur de la fenêtre et la réflexion
        }
    """
    
    # Créer le shader et le matériel
    var shader = Shader.new()
    shader.code = shader_code
    var shader_material = ShaderMaterial.new()
    shader_material.shader = shader
    self.material = shader_material
    
    # Appliquer une couleur très légère et une opacité à notre "fenêtre"
    # Par exemple, un léger gris/blanc avec une opacité de 50%
    shader_material.set("shader_param/window_color", Color(0.9, 0.9, 0.9, 1.0))  # Gris très clair
    shader_material.set("shader_param/window_opacity", 0.5)  # Opacité de 50%
    shader_material.set("shader_param/distortion_amount", 0.02)  # Quantité de distorsion
    shader_material.set("shader_param/reflection_amount", 0.3)  # Quantité de réflexion
