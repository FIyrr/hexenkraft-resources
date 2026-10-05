#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:sample_lightmap.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = Color * sample_lightmap(Sampler2, UV2);
    texCoord0 = UV0;

    // -- Custom -- //
    if (ivec4(Color * 255.5) == ivec4(187, 187, 187, 255)) { // <--- this is the color to detect
        gl_Position = ProjMat * ModelViewMat * vec4(Position + vec3(0, 24.3, 0), 1.0); // <--- this vec3(0, 6, 0) is the offset
        vertexColor = vec4(1) * sample_lightmap(Sampler2, UV2);
    }
}

