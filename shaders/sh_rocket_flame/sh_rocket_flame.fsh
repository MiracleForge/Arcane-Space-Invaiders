varying vec2 v_vTexcoord;
uniform float u_time;

void main() {
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);

    float pulse = sin(u_time * 5.0) * 0.1 + 1.0;
    float flicker = sin(u_time * 12.0) * 0.4 + 0.8;

    // 💡 Aplique um "tint" de cor azul (altere aqui pra outras cores se quiser)
    col.rgb *= vec3(0.4, 0.6, 1.5); // azul claro

    col.rgb *= pulse;
    col.a *= flicker;

    gl_FragColor = vec4(1.0, 0.0, 0.0, 0.0);
}



