shader_type canvas_item;

uniform sampler2D texture_vitre;  // Texture de la vitre
uniform float distorsion_intensity : hint_range(0.0, 1.0);  // Intensité de la distorsion
uniform vec2 uv_offset : hint_range(-1.0, 1.0);  // Décalage des UVs pour la distorsion

void fragment() {
    // Crée une distorsion des coordonnées UV pour simuler une vitre
    vec2 uv_distorted = UV + uv_offset * sin(TIME * 2.0);

    // Récupère la couleur de la texture vitre déformée
    vec4 vitre_color = texture(texture_vitre, uv_distorted);

    // Applique un léger effet de condensation ou de changement dynamique
    vitre_color.rgb += sin(TIME) * 0.05;  // Changement de couleur au fil du temps

    // Mélange l'image sous-jacente avec la couleur de la vitre
    vec4 final_color = texture(TEXTURE, UV) * (1.0 - vitre_color.a) + vitre_color * vitre_color.a;

    // Affiche le résultat final
    COLOR = final_color;
}
