uniform float u_time;
uniform vec3 u_flameColor; // cor base da chama

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec2 uv = v_vTexcoord;

    // 🔄 Ruído sutil para instabilidade da chama
    float noise = sin(uv.x * 25.0 + u_time * 10.0) * 0.005;
    uv.y += noise;

    // 🔁 Pulsação da chama
    float pulse = sin(u_time) * 0.1 + 1.5;

    // 🔁 Alpha variável
    float alpha = 0.9 + 0.2 * sin(u_time * 3.0);

    // 🎨 Textura base
    vec4 baseColor = v_vColour * texture2D(gm_BaseTexture, uv);

    // 🔥 Gradiente vertical da cor base até escuro
    float gradient = pow(1.0 - uv.y, 2.5); // parte de baixo mais escura
    vec3 darkerFlame = u_flameColor * 0.2; // cor escura para base
    vec3 flameColor = mix(u_flameColor, darkerFlame, gradient); // cima brilhante, baixo escuro

    // ✨ Combinar textura com a cor dinâmica da chama
    baseColor.rgb = mix(baseColor.rgb, flameColor, 0.4) * pulse;

    // ✨ Aplicar transparência
    baseColor.a *= alpha;

    gl_FragColor = baseColor;
}

