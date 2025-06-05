varying vec2 v_vTexcoord;
uniform float u_time;

void main() {
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);

    // só pra teste — deixa azul
    col.rgb *= vec3(255, 255, 255);

    // leve animação de alpha
    float flicker = sin(u_time * 10.0) * 0.3 + 0.7;
    col.a *= flicker;

    gl_FragColor = col;
}

