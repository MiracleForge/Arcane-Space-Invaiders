uniform sampler2D gm_BaseTexture;
uniform float u_dissolve_amount;
uniform vec2 u_resolution;

varying vec2 v_vTexcoord;

void main() {
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
    
    // Dissolve based on noise (you can use sprite alpha as pseudo-random)
    float threshold = fract(sin(dot(v_vTexcoord * u_resolution, vec2(12.9898,78.233))) * 43758.5453);
    
    if (threshold < u_dissolve_amount) {
        discard; // kill the fragment
    }

    gl_FragColor = color;
}
