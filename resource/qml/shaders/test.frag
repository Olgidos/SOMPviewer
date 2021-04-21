uniform sampler2D diffuseTexture;
varying vec4 texCoord;

void main(void)
{
    gl_FragColor = texture2D(diffuseTexture, texCoord.xy);
}
