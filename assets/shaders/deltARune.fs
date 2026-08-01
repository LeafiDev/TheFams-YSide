uniform sampler2D depths;
uniform float timer;
uniform float hue;

vec4 HSVToRGB(float hue, float saturation, float value, float a) {
  float huePrime = mod(hue,360.0);
  float c = (value/100.0) * (saturation/100.0);
  float x = c * (1.0 - abs(mod(huePrime/60.0, 2.0) - 1.0));
  float m = (value/100.0) - c;
  float r = 0.0;
  float g = 0.0;
  float b = 0.0;
  
  if (huePrime >= 0.0 && huePrime < 60.0) {
      r = c;
      g = x;
      b = 0.0;
  } else if (huePrime >= 60.0 && huePrime < 120.0) {
      r = x;
      g = c;
      b = 0.0;
  } else if (huePrime >= 120.0 && huePrime < 180.0) {
      r = 0.0;
      g = c;
      b = x;
  } else if (huePrime >= 180.0 && huePrime < 240.0) {
      r = 0.0;
      g = x;
      b = c;
  } else if (huePrime >= 240.0 && huePrime < 300.0) {
      r = x;
      g = 0.0;
      b = c;
  } else if (huePrime >= 300.0 && huePrime < 360.0) {
      r = c;
      g = 0.0;
      b = x;
  }
  r += m;
  g += m;
  b += m;
  return vec4(r, g, b, a);
}

vec4 RGBToHSV(float r, float g, float b, float a) {
  //Get the brightest and darkest channels
  float CMax = r;
  if (g > CMax) { CMax = g; }
  if (b > CMax) { CMax = b; }

  float CMin = r;
  if (g < CMin) { CMin = g; }
  if (b < CMin) { CMin = b; }

  float Delta = CMax - CMin;

  float H = 0.0;

  //Multiply and get the Hue
  if (CMax == r) {
      H = 60.0 * mod(((g - b) / Delta), 6.0);
  }
  if (CMax == g) {
      H = 60.0 * ((b - r) / Delta + 2.0);
  }
  if (CMax == b) {
      H = 60.0 * ((r - g) / Delta + 4.0);
  }

  //Set the saturation
  float S = 0.0;
  if (CMax != 0.0) {
      S = Delta / CMax;
  }
    
  return vec4(H, S * 100.0, CMax * 100.0, a);
}

vec4 HSVToRGB(vec4 colorInput) { return HSVToRGB(colorInput.x, colorInput.y, colorInput.z, colorInput.w); }
vec4 RGBToHSV(vec4 colorInput) { return RGBToHSV(colorInput.x, colorInput.y, colorInput.z, colorInput.w); }

vec4 sampleFunny(vec2 texture_coords) {
    vec4 calculated = RGBToHSV(Texel(depths, fract(texture_coords + vec2(timer, timer) / -7.5)) +
    (Texel(depths, fract((texture_coords * vec2(1.0, 0.5)) + vec2(timer / 15.0, timer / 20.0))) / 5.0));

    //Just allow hue shifting
    calculated.x += hue;
    return HSVToRGB(calculated);
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 floatyOffset = texture_coords + vec2(0.0, cos(timer) * 0.025);
    //Discard non white pixels
    if (Texel(tex, floatyOffset).x < 0.5) {
        float offset = sin(timer * 2.5) * 0.025;
        
        //Back and forth wave
        if (Texel(tex, floatyOffset + vec2(offset, offset)).x < 0.5) {
            return sampleFunny(floatyOffset * vec2(1.0, 10.0)) * vec4(1, 1, 1, max(0.0, (1.0 - sqrt(pow(floatyOffset.x - 0.5, 2) + pow(floatyOffset.y - 0.5, 2)) * 4.0) / 2.0)) * color;
        }
        return sampleFunny(floatyOffset) * vec4(1, 1, 1, 0.5) * color;
    }

    return sampleFunny(floatyOffset) * color;
}