extends Sprite2D

func _ready():
    # Charger la texture que vous souhaitez afficher à travers la vitre
    self.texture = preload("res://zImages/Window.jpeg")  # Remplacez par le chemin de votre image
    
    # Créer un shader pour l'effet de verre
    var shader_code = """
        shader_type canvas_item;

        uniform float dist_strength : hint_range(0.0, 1.0) = 0.02;  // Force de distorsion (réfraction du verre)
        uniform float glass_opacity : hint_range(0.0, 1.0) = 0.5;  // Opacité du verre
        uniform vec4 glass_color : hint_color = vec4(1.0, 1.0, 1.0, 0.5);  // Couleur et opacité du verre

        void fragment() {
            // Appliquer une légère distorsion à l'UV
            vec2 distorted_uv = UV + vec2(sin(UV.y * 10.0) * dist_strength, cos(UV.x * 10.0) * dist_strength);
            
            // Obtenir la couleur de la texture à la coordonnée UV distordue
            vec4 texColor = texture(TEXTURE, distorted_uv);
            
            // Mélanger la couleur du verre et la couleur de la texture
            COLOR = texColor * glass_color;  // Applique la couleur du verre avec l'opacité
        }
    """
    
    # Créer le shader et l'appliquer au matériel
    var shader = Shader.new()
    shader.code = shader_code
    var shader_material = ShaderMaterial.new()
    shader_material.shader = shader
    self.material = shader_material
    
    # Paramètres du verre
    shader_material.set("shader_param/dist_strength", 0.02)  # Réfraction faible pour un verre légèrement distordu
    shader_material.set("shader_param/glass_opacity", 0.5)  # Opacité de 50% pour le verre
    shader_material.set("shader_param/glass_color", Color(1, 1, 1, 0.5))  # Blanc avec une opacité de 50%
