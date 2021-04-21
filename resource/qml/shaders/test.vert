attribute vec4 vertexPosition;
attribute vec4 vertexTexCoord;

uniform mat4 mvp;
varying vec4 texCoord;

void main(void)
{
    gl_Position = mvp * vertexPosition;
    texCoord = vertexTexCoord;
}
