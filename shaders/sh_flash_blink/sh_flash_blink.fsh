varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_flash_strength;

void main() {
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 baseColor = texColor * v_vColour;

    vec3 flashColor = mix(baseColor.rgb, vec3(1.0), clamp(u_flash_strength, 0.0, 1.0));

    gl_FragColor = vec4(flashColor, baseColor.a);
}

