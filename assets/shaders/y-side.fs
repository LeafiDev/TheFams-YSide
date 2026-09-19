uniform vec2 mouse_screen_pos;
uniform vec2 screen_scale;
uniform float hovering;
uniform float dissolve;
uniform float time;
uniform vec2 texture_details;
uniform vec2 image_details;
uniform vec4 burn_colour_1;
uniform vec4 burn_colour_2;
uniform bool shadow;

vec4 effect(
    vec4 color,
    Image texture,
    vec2 texture_coords,
    vec2 screen_coords
) {
    float test = mouse_screen_pos.x
                  + screen_scale.x
                  + hovering
                  + dissolve
                  + time
                  + texture_details.x
                  + image_details.x
                  + burn_colour_1.r
                  + burn_colour_2.r
                  + (shadow ? 1.0 : 0.0);

    return vec4(1.0, 0.0, 0.0, 1.0);
}