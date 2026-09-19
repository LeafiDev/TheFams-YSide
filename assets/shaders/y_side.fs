extern number time;

vec4 effect(
    vec4 color,
    Image texture,
    vec2 texture_coords,
    vec2 screen_coords
) {
    vec2 uv = texture_coords;

    float wave1 = sin(uv.x * 8.0 + time * 0.4);
    float wave2 = sin(uv.y * 6.0 - time * 0.3);

    float pattern = (wave1 + wave2) * 0.5;
    pattern = pattern * 0.5 + 0.5;

    vec3 color1 = vec3(0.08, 0.04, 0.12);
    vec3 color2 = vec3(0.35, 0.12, 0.30);

    vec3 result = mix(color1, color2, pattern);

    return vec4(result, 1.0);
}