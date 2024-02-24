#include <flutter/runtime_effect.glsl>

uniform vec2 targetSize;
out vec4 fragColor;

void main() {
    vec2 uv_aspect = FlutterFragCoord().xy / targetSize;

    fragColor = vec4(uv_aspect, 0.0, 1.0);
}
