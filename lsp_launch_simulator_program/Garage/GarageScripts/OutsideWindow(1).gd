extends Sprite2D

# This function will be called when the node is ready (initialization)
func _ready():
    # Create a Shader for the glass-like effect
    var shader_code = """
        shader_type canvas_item;

        // Uniform parameters for controlling the glass effect
        uniform float dist_strength : hint_range(0.0, 1.0) = 0.02;  // Strength of the refraction effect
        uniform float glass_opacity : hint_range(0.0, 1.0) = 0.5;  // Opacity of the glass
        uniform vec4 glass_color : hint_color = vec4(1.0, 1.0, 1.0, 0.5);  // Color of the glass with opacity

        void fragment() {
            // Apply a slight distortion to the texture's UV coordinates to simulate refraction
            vec2 distorted_uv = UV + vec2(sin(UV.y * 10.0) * dist_strength, cos(UV.x * 10.0) * dist_strength);
            
            // Get the color of the texture at the distorted coordinates
            vec4 texColor = texture(TEXTURE, distorted_uv);
            
            // Mix the texture color with the glass color
            COLOR = texColor * glass_color;  // Apply the glass effect with transparency
        }
    """
    
    # Create the Shader
    var shader = Shader.new()
    shader.code = shader_code  # Assign the shader code to the shader object
    
    # Create a ShaderMaterial and apply it to the sprite
    var shader_material = ShaderMaterial.new()
    shader_material.shader = shader
    self.material = shader_material  # Set the material of the sprite to this shader material
    
    # Set initial parameters for the glass effect
    shader_material.set("shader_param/dist_strength", 0.02)  # Light refraction strength
    shader_material.set("shader_param/glass_opacity", 0.5)  # 50% opacity for the glass effect
    shader_material.set("shader_param/glass_color", Color(1, 1, 1, 0.5))  # White glass with opacity 50%
